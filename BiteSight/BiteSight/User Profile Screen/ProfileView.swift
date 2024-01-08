//
//  ProfileView.swift
//  BiteSight
//
//  Created by Jacqueline Guo on 12/5/23.
//

import UIKit

class ProfileView: UIView {

    var imageIcon: UIImageView!
    var nameIcon: UIImageView!
    var nameLabel: UILabel!
    var emailIcon: UIImageView!
    var emailLabel: UILabel!
    var cityIcon: UIImageView!
    var cityLabel: UILabel!
    var stateIcon: UIImageView!
    var stateLabel: UILabel!
    var zipIcon: UIImageView!
    var zipLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupImageIcon()
        setupNameIcon()
        setupName()
        setupEmailIcon()
        setupEmail()
        setupCityIcon()
        setupCity()
        setupStateIcon()
        setupState()
        setupZipIcon()
        setupZip()
        setupConstraints()
    }
    
    func setupImageIcon() {
        imageIcon = UIImageView()
        imageIcon.image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal)
        imageIcon.tintColor = .black
        imageIcon.contentMode = .scaleToFill
        imageIcon.layer.borderWidth = 1
        imageIcon.layer.masksToBounds = false
        imageIcon.layer.borderColor = UIColor.white.cgColor
        imageIcon.layer.cornerRadius = 120 / 2
        imageIcon.clipsToBounds = true
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageIcon)
    }
    
    func setupNameIcon() {
        nameIcon = UIImageView()
        nameIcon.image = UIImage(systemName: "person.text.rectangle")
        nameIcon.tintColor = .black
        nameIcon.contentMode = .scaleToFill
        nameIcon.clipsToBounds = true
        nameIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameIcon)
    }
    
    func setupName() {
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
    }
    
    func setupEmailIcon() {
        emailIcon = UIImageView()
        emailIcon.image = UIImage(systemName: "envelope.circle")
        emailIcon.tintColor = .black
        emailIcon.contentMode = .scaleToFill
        emailIcon.clipsToBounds = true
        emailIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailIcon)
    }
    
    func setupEmail() {
        emailLabel = UILabel()
        emailLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailLabel)
    }
    
    func setupCityIcon() {
        cityIcon = UIImageView()
        cityIcon.image = UIImage(systemName: "building.2")
        cityIcon.tintColor = .black
        cityIcon.contentMode = .scaleToFill
        cityIcon.clipsToBounds = true
        cityIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cityIcon)
    }
    
    func setupCity() {
        cityLabel = UILabel()
        cityLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cityLabel)
    }
    
    func setupStateIcon() {
        stateIcon = UIImageView()
        stateIcon.image = UIImage(systemName: "globe.americas")
        stateIcon.tintColor = .black
        stateIcon.contentMode = .scaleToFill
        stateIcon.clipsToBounds = true
        stateIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stateIcon)
    }
    
    func setupState() {
        stateLabel = UILabel()
        stateLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stateLabel)
    }
    
    func setupZipIcon() {
        zipIcon = UIImageView()
        zipIcon.image = UIImage(systemName: "123.rectangle.fill")
        zipIcon.tintColor = .black
        zipIcon.contentMode = .scaleToFill
        zipIcon.clipsToBounds = true
        zipIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(zipIcon)
    }
    
    func setupZip() {
        zipLabel = UILabel()
        zipLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        zipLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(zipLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageIcon.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageIcon.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            imageIcon.widthAnchor.constraint(equalToConstant: 120),
            imageIcon.heightAnchor.constraint(equalToConstant: 120),
            
            nameIcon.topAnchor.constraint(equalTo: imageIcon.bottomAnchor, constant: 40),
            nameIcon.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: imageIcon.bottomAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: nameIcon.trailingAnchor, constant: 10),
            
            emailIcon.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 14),
            emailIcon.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 14),
            emailLabel.leadingAnchor.constraint(equalTo: emailIcon.trailingAnchor, constant: 14),

            cityIcon.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 14),
            cityIcon.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            
            cityLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 14),
            cityLabel.leadingAnchor.constraint(equalTo: cityIcon.trailingAnchor, constant: 10),
            
            stateIcon.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 14),
            stateIcon.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            
            stateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 14),
            stateLabel.leadingAnchor.constraint(equalTo: stateIcon.trailingAnchor, constant: 14),
            
            zipIcon.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 14),
            zipIcon.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            
            zipLabel.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 14),
            zipLabel.leadingAnchor.constraint(equalTo: zipIcon.trailingAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
