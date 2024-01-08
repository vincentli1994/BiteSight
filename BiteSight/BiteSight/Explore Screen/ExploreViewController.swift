////
////  ExploreViewController.swift
////  BiteSight
////
////  Created by (Vincent) GuoWei Li on 11/22/23.
////
//
import UIKit
import CoreLocation
import Alamofire
import Koloda
import FirebaseAuth
import FirebaseFirestore

class ExploreViewController: UIViewController {
    
    let exploreView = ExploreView()
    let dataService = DataService()
    var businessList = [Business]()
    var businessImages = [UIImage]()
    var businessCards = [BusinessCardView]()
    var isButtonInitiatedSwipe = false
    let db = Firestore.firestore()
    
    override func loadView() {
        view = exploreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exploreView.kolodaView.delegate = self
        exploreView.kolodaView.dataSource = self
        exploreView.dislikeButton.addTarget(self, action: #selector(dislikeButtonTapped), for: .touchUpInside)
        exploreView.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        view.backgroundColor = .white
        LocationFetcher.shared.getUserLocation { location in
            print("location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            self.dataService.getCloseByRestaurants(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let businesses):
                        self.businessList = businesses
                        print("printing business: \(self.businessList)")
                        Task {
                            await self.setupBusinessCards()
                        }
                        // Update UI with businesses
                    case .failure(let error):
                        print("Error fetching businesses: \(error)")
                        // Handle error, update UI if needed
                    }
                }
            }
        }
    }
    
    @objc func dislikeButtonTapped() {
        let currentIndex = exploreView.kolodaView.currentCardIndex
        isButtonInitiatedSwipe = true
        handleSwipeForBusiness(atIndex: currentIndex, direction: .left)
        exploreView.kolodaView.swipe(.left)
    }
    
    @objc func likeButtonTapped() {
        let currentIndex = exploreView.kolodaView.currentCardIndex
        isButtonInitiatedSwipe = true
        handleSwipeForBusiness(atIndex: currentIndex, direction: .right)
        exploreView.kolodaView.swipe(.right)
    }
    
    func handleSwipeForBusiness(atIndex index: Int, direction: SwipeResultDirection) {
        if direction == .right {
            let swipedBusiness = businessList[index]
            guard let userEmail = Auth.auth().currentUser?.email else {
                print("No user signed in")
                return
            }
            guard let businessId = swipedBusiness.id else {
                    print("Business ID is nil")
                    return
            }
            let businessRef = db.collection("users").document(userEmail).collection("businesses").whereField("id", isEqualTo: businessId)
            businessRef.getDocuments { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else if querySnapshot!.documents.isEmpty {
                        // Business ID not found, save the business
                        self.saveBusinessToFirebase(business: swipedBusiness, userEmail: userEmail)
                    } else {
                        print("Business already exists in the database")
                    }
                }
        }
        // Add logic for .left direction if needed
    }
    
    // Asynchronous function to download an image
    func downloadImage(urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else {
            return nil // Return nil if URL is invalid
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            return nil // Return nil in case of an error
        }
    }
    
    func setupBusinessCards() async {
        //        var downloadedImages = [UIImage?]()
        var tempBusinessCards = [BusinessCardView]()
        print("entering setupBusinessCards:")
        print("businessCards initial count: \(businessCards.count)")
        for business in businessList {
            print("iterating business list")
            if let urlString = business.imageUrl {
                let image = await self.downloadImage(urlString: urlString)
                let businessImage = image ?? UIImage(named: "default_restaurant") // Replace "defaultImage" with your default image name
                let businessName = business.name ?? ""
                let businessCategory = business.categories?.first?.title ?? ""
                //                print("business name is: \(name)")
                //                print("business category title is: \(categoryTitle)")
                let card = BusinessCardView()
                card.businessImage.image = businessImage
                print("set image")
                card.businessName.text = businessName.uppercased()
                print("set name")
                card.businessCategory.setTitle(businessCategory.uppercased(), for: .normal)
                print("set title")
                //                downloadedImages.append(image)
                tempBusinessCards.append(card)
                print("added card to temp")
                print("temp count: \(tempBusinessCards.count)")
                
            } else {
                //                downloadedImages.append(UIImage()) // Placeholder image
                tempBusinessCards.append(BusinessCardView())
            }
        }
        
        //        print("final businessCards count: \(tempBusinessCards.count)")
        
        // Update businessImages on the main thread after all downloads are complete
        DispatchQueue.main.async {
            print("final businessCards count: \(tempBusinessCards.count)")
            
            //            self.businessImages = downloadedImages.compactMap { $0 } // Filter out nil images if necessary
            //            self.reloadImages()
            self.businessCards = tempBusinessCards
            self.reloadImages()
        }
    }
    
    func reloadImages() {
        exploreView.kolodaView.reloadData()
    }
    
    func saveBusinessToFirebase(business: Business, userEmail: String) {
        // Reference to Firestore
        print("saving business to firebase ...")
        // Convert your business object to a dictionary
        // Convert custom objects to dictionaries
        let category = business.categories?.first?.title ?? ""
        let latitude = business.coordinates?.latitude ?? 0
        let longitude = business.coordinates?.longitude ?? 0
        let address = business.location?.address1 ?? ""
        let city = business.location?.city ?? ""
        let zipCode = business.location?.zipCode ?? ""
        let state = business.location?.state ?? ""
        let country = business.location?.country ?? ""
        let displayAddress = business.location?.displayAddress
        
        
        // Convert your business object to a dictionary
        let businessData: [String: Any?] = [
            "id": business.id,
            "name": business.name,
            "imageUrl": business.imageUrl,
            "reviewCount": business.reviewCount,
            "category": category,
            "rating": business.rating,
            "latitude": latitude,
            "longtitude": longitude,
            "price": business.price,
            "address": address,
            "city": city,
            "zipCode": zipCode,
            "state": state,
            "country": country,
            "displayAddress": displayAddress,
            "displayPhone": business.displayPhone,
            "distance": business.distance
        ]
        
        print("business data: \(businessData)")
        // Add the business data to the user's business collection
        db.collection("users").document(userEmail).collection("businesses").addDocument(data: businessData) { error in
            if let error = error {
                print("Error adding business document: \(error)")
            } else {
                print("Business document added successfully")
            }
        }
    }
}

extension ExploreViewController: KolodaViewDelegate, KolodaViewDataSource {
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        //        return UIImageView(image: businessImages[index])
        return businessCards[index]
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        //        return businessImages.count
        return businessCards.count
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        self.reloadImages()
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if !isButtonInitiatedSwipe {
            handleSwipeForBusiness(atIndex: index, direction: direction)
        }
        
        isButtonInitiatedSwipe = false
    }
}

