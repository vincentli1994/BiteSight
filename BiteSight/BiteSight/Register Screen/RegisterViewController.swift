//
//  RegisterViewController.swift
//  BiteSight
//
//  Created by Jacqueline Guo on 11/20/23.
//

import UIKit
import PhotosUI
import FirebaseAuth
import FirebaseStorage

class RegisterViewController: UIViewController {
    
    var delegate: ViewController!
    
    let registerView = RegisterView()
    
    let childProgressView = ProgressSpinnerViewController()
    
    var pickedImage: UIImage?
    
    let storage = Storage.storage()
    
    override func loadView() {
        view = registerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.selectPhoto.menu = getMenuImagePicker()
        registerView.createButton.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        title = "Register"
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

    
    @objc func onRegisterTapped(){
        showActivityIndicator()
        uploadProfilePhotoToStorage()
    }
}
