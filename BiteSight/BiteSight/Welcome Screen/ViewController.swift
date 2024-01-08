//
//  ViewController.swift
//  BiteSight
//
//  Created by Jacqueline Guo on 11/20/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    let welcomeView = WelcomeView()
    
    override func loadView() {
        view = welcomeView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"
        
        print("Check for current user: \(Validation.defaults.object(forKey: "auth"))")
        if let temp = Validation.defaults.object(forKey: "auth") as! String? {
            navigateToLanding()
        }
        
        welcomeView.loginButton.addTarget(self, action: #selector(onSignInButtonTapped), for: .touchUpInside)
        welcomeView.registerButton.addTarget(self, action: #selector(onRegisterButtonTapped), for: .touchUpInside)
    }
    
    @objc func onRegisterButtonTapped() {
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }

    @objc func onSignInButtonTapped() {
        let signInAlert = UIAlertController(
            title: "Sign In",
            message: "Please sign in to continue.",
            preferredStyle: .alert)

        signInAlert.addTextField{ textField in
            textField.placeholder = "Enter email"
            textField.contentMode = .center
            textField.keyboardType = .emailAddress
        }

        signInAlert.addTextField{ textField in
            textField.placeholder = "Enter password"
            textField.contentMode = .center
            textField.isSecureTextEntry = true
        }

        let signInAction = UIAlertAction(title: "Sign In", style: .default, handler: {(_) in
            if let email = signInAlert.textFields![0].text,
               let password = signInAlert.textFields![1].text{
                self.signInToFirebase(email: email, password: password)
            }
        })
        
        signInAlert.addAction(signInAction)
        
        self.present(signInAlert, animated: true, completion: {() in
            signInAlert.view.superview?.isUserInteractionEnabled = true
            signInAlert.view.superview?.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(self.onTapOutsideAlert))
            )
        })
    }
    
    @objc func onTapOutsideAlert(){
        self.dismiss(animated: true)
    }
    
    func signInToFirebase(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if let maybeError = error {
                let err = maybeError as NSError
                switch err.code {
                case AuthErrorCode.internalError.rawValue:
                    self.showAlert(with: "Incorrect Username or Password", message: "The username or password you entered is incorrect. Please try again.")
                default:
                    self.showAlert(with: "Login Error", message: "An error occurred during login: \(error!.localizedDescription)")
                }
            } else {
                Validation.defaults.set(email, forKey: "auth")
                print("Current user saved: \(Validation.defaults.object(forKey: "auth"))")
                print(Validation.defaults.object(forKey: "auth"))
                self.navigateToLanding()
            }
        })
    }
    
    private func navigateToLanding() {
        let landingViewController = LandingViewController()
        self.navigationController?.pushViewController(landingViewController, animated: true)
    }	
    
    func showAlert(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

