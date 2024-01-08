//
//  FavoriteViewController.swift
//  BiteSight
//
//  Created by (Vincent) GuoWei Li on 11/22/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
//import FirebaseFirestoreSwift

class FavoriteViewController: UIViewController {
    let favoriteView = FavoriteView()
    var favorites = [Business]()
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
        
//        favorites.append(Restaurant(name: "McDonald's", address: "1042 N Ave", zip: "CA 94323", likes: 32891, photo: UIImage(systemName: "person.fill")!, description: "Globally renowned fast-food chain that originated in the United States."))
//        favorites.append(Restaurant(name: "KFC", address: "232 Parker Ave", zip: "CA 94117", likes: 12345, photo: UIImage(systemName: "square.and.arrow.up")!, description: "KFC is a popular international fast-food chain that specializes in fried chicken. The brand is famous for its secret blend of 11 herbs and spices, used in its original recipe chicken. KFC's menu typically includes a variety of fried chicken pieces, as well as sides such as mashed potatoes, coleslaw, and biscuits. The franchise has a global presence and is known for its distinctive red and white color scheme."))
//        favorites.append(Restaurant(name: "Somi Somi", address: "1531 Berryessa Rd", zip: "95133", likes: 412, photo: UIImage(systemName: "pencil")!, description: "Somi Somi is a dessert shop that gained popularity for its unique Korean-inspired desserts, particularly its signature item, the Ah-boong."))
        
        favoriteView.tableViewFavorites.reloadData()
    }
}
