//
//  ContactsTableViewManager.swift
//  App12
//
//  Created by Sakib Miazi on 6/2/23.
//

import Foundation
import UIKit
import FirebaseAuth

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewHomeID, for: indexPath) as! HomeTableViewCell
        cell.business = businessList[indexPath.row]
        cell.labelName.text = businessList[indexPath.row].name
        if let name = businessList[indexPath.row].name, self.favoritesName.contains(name) {
            cell.likeButton.isSelected = true
        } else {
            cell.likeButton.isSelected = false
        }
        if let address = businessList[indexPath.row].location?.address1 {
            cell.labelAddress.text = address
        }
        cell.labelPrice.text = businessList[indexPath.row].price
        if let catagory = businessList[indexPath.row].categories {
            if let alias = catagory[0].alias {
                cell.labelCategory.text = alias
            }
        }
        
        Validation.urlToImage(businessList[indexPath.row].imageUrl) { image in
            DispatchQueue.main.async {
                cell.restaurantImageView.image = image
            }
        }
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(didTapLikeButton(_:)), for: .touchUpInside)
        cell.contentView.bringSubviewToFront(cell.likeButton)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = Auth.auth().currentUser {
            let detailsController = DetailsViewController()
            let data = businessList[indexPath.row]
            let docId = data.id
            var id: String? = nil
            var name: String? = nil
            var category: String? = nil
            var imageUrl: String? = nil
            var price: String? = nil
            var rating: Int? = nil
            var reviewCount: Int? = nil
            var address: String? = nil
            var city: String? = nil
            var state: String? = nil
            var country: String? = nil
            var zipCode: String? = nil
            var displayAddress: [String]? = nil
            var displayPhone: String? = nil
            var distance: Double? = nil
            var latitude: Double? = nil
            var longtitude: Double? = nil
            
            if let temp = data.id as? String {
                id = temp
            }
            if let temp = data.name as? String {
                name = temp
            }
            if let temp = data.categories as? String {
                category = temp
            }
            if let temp = data.imageUrl as? String {
                imageUrl = temp
            }
            if let temp = data.price as? String {
                price = temp
            }
            if let temp = data.rating as? Int {
                rating = temp
            }
            if let temp = data.reviewCount as? Int {
                reviewCount = temp
            }
            if let temp = data.location?.address1 as? String {
                address = temp
            }
            if let temp = data.location?.city as? String {
                city = temp
            }
            if let temp = data.location?.state as? String {
                state = temp
            }
            if let temp = data.location?.country as? String {
                country = temp
            }
            if let temp = data.location?.zipCode as? String {
                zipCode = temp
            }
            if let temp = data.location?.displayAddress as? [String] {
                displayAddress = temp
            }
            if let temp = data.displayPhone as? String {
                displayPhone = temp
            }
            if let temp = data.distance as? Double {
                distance = temp
            }
            if let temp = data.coordinates?.latitude as? Double {
                latitude = temp
            }
            if let temp = data.coordinates?.longitude as? Double {
                longtitude = temp
            }
            
            let restaurant = Restaurant(docId: docId, id: id, name: name, category: category, imageUrl: imageUrl, price: price, rating: rating, reviewCount: reviewCount, address: address, city: city, state: state, country: country, zipCode: zipCode, displayAddress: displayAddress, displayPhone: displayPhone, distance: distance, latitude: latitude, longtitude: longtitude)
            
            // Access the cell and its likeButton
            if let cell = tableView.cellForRow(at: indexPath) as? HomeTableViewCell {
                let isLiked = cell.likeButton.isSelected
                print("Is Liked: \(isLiked)")
                // You can pass this state to your detailsController if needed
                detailsController.isLiked = isLiked
            }
            
            detailsController.receivedRestaurant = restaurant
            navigationController?.pushViewController(detailsController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func didTapLikeButton(_ sender: UIButton) {
        guard let tableView = self.homeView.tableViewStores else { return }
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: buttonPosition) {
            sender.isSelected.toggle() // Toggle the selected state of the button
            
            let business = businessList[indexPath.row]
            
            // Change the button appearance based on whether it's selected
            let imageName = sender.isSelected ? "heart.circle.fill" : "heart"
            sender.setImage(UIImage(systemName: imageName), for: .normal)
            
            // Optionally animate the button to give feedback to the user
            UIView.animate(withDuration: 0.2, animations: {
                sender.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }, completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    sender.transform = CGAffineTransform.identity
                }
            })
            
            // Call respective functions based on the button's selected state
            if sender.isSelected {
                saveBusinessToFirebase(business: business)
            } else {
                dislikeRestaurant(business: business)
            }
        }
    }
    
    func saveBusinessToFirebase(business: Business) {
        guard let userEmail = Auth.auth().currentUser?.email else {
            print("No user signed in")
            return
        }
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
        self.database.collection("users").document(userEmail).collection("businesses").addDocument(data: businessData) { error in
            if let error = error {
                print("Error adding business document: \(error)")
            } else {
                print("Business document added successfully")
            }
        }
    }
    
    func dislikeRestaurant(business: Business) {
        if let currUser = Validation.defaults.object(forKey: "auth") as? String {
            // Query the collection to find the document with the matching name
            let query = database.collection("users").document(currUser).collection("businesses").whereField("name", isEqualTo: business.name)

            query.getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        // Delete the document
                        document.reference.delete { error in
                            if let error = error {
                                print("Error deleting document: \(error)")
                            } else {
                                if let name = business.name, let index = self.favoritesName.firstIndex(of: name) {
                                    self.favoritesName.remove(at: index)
                                }

                                print("Document successfully deleted.")
                            }
                        }
                    }
                }
            }
        }
    }
}
