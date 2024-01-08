//
//  Validation.swift
//  BiteSight
//
//  Created by Jacqueline Guo on 11/20/23.
//

import Foundation
import UIKit
import Alamofire

class Validation {
    static let defaults = UserDefaults.standard
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidPhone(_ phone: String) -> Bool {
        let characterSet = CharacterSet.decimalDigits.inverted
        return phone.rangeOfCharacter(from: characterSet) == nil
    }
    
    static func isValidUsername(_ username: String) -> Bool {
        let usernameRegex = "^[A-Za-z0-9]{3,10}$"
        let usernamePred = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernamePred.evaluate(with: username)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^[A-Za-z0-9]{8,16}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: password)
    }
    
    static func showErrorAlert(_ view: UIViewController, _ text: String) {
        let alert = UIAlertController(title: "Error!", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        view.present(alert, animated: true)
    }
    
    static func urlToImage(_ imageUrl: String?, completion: @escaping (UIImage?) -> Void) {
        if let imageUrl = imageUrl {
            AF.request(imageUrl).responseData { response in
                switch response.result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        completion(image)
                    }
                case .failure(let error):
                    print("Error downloading image: \(error)")
                }
            }
        }
    }
}
