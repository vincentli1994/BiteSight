//
//  ProfileViewController.swift
//  BiteSight
//
//  Created by Jacqueline Guo on 12/5/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PhotosUI
import FirebaseStorage

class ProfileViewController: UIViewController {

    let profileView = ProfileView()
    
    let storage = Storage.storage()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    var userListener: ListenerRegistration?
    var email: String!
    var pickedImage: UIImage?
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Me"
        
        handleAuth = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                self.currentUser = user
                self.email = user.email
                self.profileView.nameLabel.text = "Name: \(user.displayName ?? "Anonymous")"
                self.profileView.emailLabel.text = "Email: \(user.email ?? "None")"
                self.listenForUserProfileChanges(uid: user.email!)
            }
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit Profile", style: .plain, target: self, action: #selector(onEditTapped))
    }
    
    @objc func onEditTapped() {
        let editProfileScreen = EditProfileViewController()
        navigationController?.pushViewController(editProfileScreen, animated: true)
    }
    
    deinit {
        handleAuth.map(Auth.auth().removeStateDidChangeListener)
        userListener?.remove()
    }
    
    private func listenForUserProfileChanges(uid: String) {
        userListener = Firestore.firestore().collection("users").document(uid).addSnapshotListener { [weak self] documentSnapshot, error in
            guard let self = self else { return }

            if let error = error {
                print("Error fetching document: \(error)")
                return
            }

            guard let document = documentSnapshot, document.exists else {
                print("Document does not exist")
                return
            }

            let data = document.data()
            self.profileView.nameLabel.text = "Name: \(data?["name"] as? String ?? "Anonymous")"
            self.profileView.cityLabel.text = "City: \(data?["city"] as? String ?? "None")"
            self.profileView.stateLabel.text = "State: \(data?["state"] as? String ?? "None")"
            self.profileView.zipLabel.text = "Zip: \(data?["zip"] as? String ?? "None")"
            
            if let photoURLString = data?["photoURL"] as? String, let photoURL = URL(string: photoURLString) {
               self.profileView.imageIcon.loadRemoteImage(from: photoURL)
           }
        }
    }
}
