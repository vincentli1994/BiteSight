//
//  WelcomeView.swift
//  BiteSight
//
//  Created by Jacqueline Guo on 11/20/23.
//

import UIKit

class WelcomeView: UIView {

    var appLabel: UILabel!
    var appIcon: UIImageView!
    var loginButton: UIButton!
    var registerButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupAppIcon()
        setupAppLabel()
        setupLoginButton()
        setupRegisterButton()
        initConstraints()
    }
    
    func setupAppIcon() {
        appIcon = UIImageView()
        appIcon.image = UIImage(named: "logo")
        appIcon.tintColor = .black
        appIcon.contentMode = .scaleToFill
        appIcon.clipsToBounds = true
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(appIcon)
    }
    
    func setupAppLabel() {
        appLabel = UILabel()
        appLabel.text = "Bite Sight"
        appLabel.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
        appLabel.textColor = .black
        appLabel.textAlignment = .center
        appLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(appLabel)
    }
    
    func setupLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.tintColor = .white
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        loginButton.layer.borderColor = UIColor.systemTeal.cgColor
        loginButton.layer.borderWidth = 3
        loginButton.layer.cornerRadius = 25.0
        loginButton.layer.backgroundColor = UIColor.systemTeal.cgColor
        loginButton.layer.masksToBounds = true
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginButton)
    }

    func setupRegisterButton() {
        registerButton = UIButton(type: .system)
        registerButton.setTitle("Sign Up", for: .normal)
        registerButton.tintColor = .white
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        registerButton.layer.borderColor = UIColor.systemTeal.cgColor
        registerButton.layer.borderWidth = 3
        registerButton.layer.cornerRadius = 25.0
        registerButton.layer.backgroundColor = UIColor.systemTeal.cgColor
        registerButton.layer.masksToBounds = true
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(registerButton)
    }

    func initConstraints(){
        NSLayoutConstraint.activate([
            appIcon.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            appIcon.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            appIcon.widthAnchor.constraint(equalToConstant: 160),
            appIcon.heightAnchor.constraint(equalToConstant: 160),
            
            appLabel.topAnchor.constraint(equalTo: appIcon.bottomAnchor, constant: 30),
            appLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 70),
            loginButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.widthAnchor.constraint(equalToConstant: 220),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 60),
            registerButton.widthAnchor.constraint(equalToConstant: 220)
            
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
