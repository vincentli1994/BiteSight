//
//  FavoriteViewController.swift
//  BiteSight
//
//  Created by Tiffany Zhang on 11/30/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FavoriteViewController: UIViewController {
    let favoriteView = FavoriteView()
    var favorites = [Restaurant]()
    let database = Firestore.firestore()
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    override func loadView() {
        view = favoriteView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // handle if the Authentication state is changed (sign in, sign out, register)
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user != nil{
                self.getAllFavorites()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        
        favoriteView.tableViewFavorites.delegate = self
        favoriteView.tableViewFavorites.dataSource = self
        favoriteView.tableViewFavorites.separatorStyle = .none
    }
    
    func getAllFavorites() {
        favorites.removeAll()
        
        if let currUser = Validation.defaults.object(forKey: "auth") as! String? {
            let businessCollection = database.collection("users").document(currUser).collection("businesses")
            businessCollection.addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                for document in documents {
                    let data = document.data()
                    let docId = document.documentID
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
                    
                    if let temp = data["id"] as? String {
                        id = temp
                    }
                    if let temp = data["name"] as? String {
                        name = temp
                    }
                    if let temp = data["category"] as? String {
                        category = temp
                    }
                    if let temp = data["imageUrl"] as? String {
                        imageUrl = temp
                    }
                    if let temp = data["price"] as? String {
                        price = temp
                    }
                    if let temp = data["rating"] as? Int {
                        rating = temp
                    }
                    if let temp = data["reviewCount"] as? Int {
                        reviewCount = temp
                    }
                    if let temp = data["address"] as? String {
                        address = temp
                    }
                    if let temp = data["city"] as? String {
                        city = temp
                    }
                    if let temp = data["state"] as? String {
                        state = temp
                    }
                    if let temp = data["country"] as? String {
                        country = temp
                    }
                    if let temp = data["zipCode"] as? String {
                        zipCode = temp
                    }
                    if let temp = data["displayAddress"] as? [String] {
                        displayAddress = temp
                    }
                    if let temp = data["displayPhone"] as? String {
                        displayPhone = temp
                    }
                    if let temp = data["distance"] as? Double {
                        distance = temp
                    }
                    if let temp = data["latitude"] as? Double {
                        latitude = temp
                    }
                    if let temp = data["longtitude"] as? Double {
                        longtitude = temp
                    }
                    
                    let restaurant = Restaurant(docId: docId, id: id, name: name, category: category, imageUrl: imageUrl, price: price, rating: rating, reviewCount: reviewCount, address: address, city: city, state: state, country: country, zipCode: zipCode, displayAddress: displayAddress, displayPhone: displayPhone, distance: distance, latitude: latitude, longtitude: longtitude)
                    
                    self.favorites.append(restaurant)
                }

                DispatchQueue.main.async {
                    print()
                    print("self.favorites:")
                    print()
                    print(self.favorites)
                    self.favoriteView.tableViewFavorites.reloadData()
                }
            }
        }
        
        
        
        favoriteView.tableViewFavorites.reloadData()
    }
}
