//
//  EditProfileViewController.swift
//  BiteSight
//
//  Created by Jacqueline Guo on 12/8/23.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import PhotosUI

class EditProfileViewController: UIViewController {
    
    var editProfileView = EditProfileView()
    
    let storage = Storage.storage()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    var userListener: ListenerRegistration?
    var email: String!
    var pickedImage: UIImage?
    
    override func loadView() {
        view = editProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        editProfileView.selectPhoto.menu = getMenuImagePicker()
        
        handleAuth = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                self.currentUser = user
            }
        }

        editProfileView.createButton.addTarget(self, action: #selector(onSaveButtonTapped), for: .touchUpInside)
    }
    
    func getMenuImagePicker() -> UIMenu{
        var menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    @objc func onSaveButtonTapped() {
        
        guard let currentUser = Auth.auth().currentUser else {
                print("No current user found")
                return
            }
            
        let email = currentUser.email ?? ""
        
        var updateData: [String: Any] = [:]

        // Check if the name is changed and add it to the updateData dictionary
        if let name = editProfileView.nameTextField.text, !name.isEmpty {
            updateData["name"] = name
        }
        
        if let city = editProfileView.cityTextField.text, !city.isEmpty {
            updateData["city"] = city
        }
        
        if let state = editProfileView.stateTextField.text, !state.isEmpty {
            updateData["state"] = state
        }
        
        if let zip = editProfileView.zipTextField.text, !zip.isEmpty {
            updateData["zip"] = zip
        }
        
        if let pickedImage = pickedImage {
            uploadProfilePhotoToStorage(image: pickedImage, userEmail: email) { [weak self] url in
                guard let self = self, let downloadURL = url else { return }
                
                // Add the photoURL to the updateData dictionary
                updateData["photoURL"] = downloadURL.absoluteString
                
                // Update the user profile with the changed name and/or photo
                self.updateFirestoreUserProfile(uid: email, data: updateData)
            }
        } else {
            // If no new photo is selected, update the user profile with only the name change
            if !updateData.isEmpty {
                updateFirestoreUserProfile(uid: email, data: updateData)
            }
        }

        self.navigationController?.popViewController(animated: true)
    }
        
    func uploadProfilePhotoToStorage(image: UIImage, userEmail: String, completion: @escaping (URL?) -> Void) {
        guard let jpegData = image.jpegData(compressionQuality: 0.8) else {
            print("Could not get JPEG representation of UIImage")
            return
        }
        
        let storageRef = storage.reference()
        let photoRef = storageRef.child("imagesUsers")
        let imageRef = photoRef.child("\(NSUUID().uuidString).jpg")
        
        imageRef.putData(jpegData, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                print("Error uploading photo: \(String(describing: error))")
                completion(nil)
                return
            }
            
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("Error getting download URL: \(String(describing: error))")
                    completion(nil)
                    return
                }
                completion(downloadURL)
            }
        }
    }
    
    private func updateFirestoreUserProfile(uid: String, data: [String: Any]) {
        Firestore.firestore().collection("users").document(uid).updateData(data) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}
