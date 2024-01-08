//
//  BusinessCardView.swift
//  BiteSight
//
//  Created by (Vincent) GuoWei Li on 11/29/23.
//

import UIKit

class BusinessCardView: UIView {
    
    var businessImage: UIImageView!
    var businessName: UILabel!
    var businessCategory: UIButton!
    var separator: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // Create UIImageView
        businessImage = UIImageView()
        businessImage.layer.cornerRadius = 24
        businessImage.clipsToBounds = true // Add this line
        businessImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(businessImage)
        
        // Create UILabel
        businessName = UILabel()
        businessName.textColor = .white
        businessName.textAlignment = .center
        businessName.font = .systemFont(ofSize: 25, weight: .bold)
        businessName.adjustsFontSizeToFitWidth = true
        businessName.minimumScaleFactor = 0.5 // Adjust as needed
        businessName.numberOfLines = 1 // To ensure the text stays in one line
        businessName.translatesAutoresizingMaskIntoConstraints = false
        businessImage.addSubview(businessName)
        
        separator = UIView()
        separator.backgroundColor = .white
        separator.translatesAutoresizingMaskIntoConstraints = false
        businessImage.addSubview(separator)
        
        businessCategory = UIButton()
        businessCategory.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        businessCategory.backgroundColor = .white
        businessCategory.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        businessCategory.layer.cornerRadius = 15
        businessCategory.setTitleColor(.black, for: .normal)
        businessCategory.translatesAutoresizingMaskIntoConstraints = false
        businessImage.addSubview(businessCategory)
        
        // Set label constraints
        NSLayoutConstraint.activate([
            businessImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: -10),
            businessImage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            businessImage.widthAnchor.constraint(equalToConstant: 360),
            businessImage.heightAnchor.constraint(equalToConstant: 530),

            businessName.bottomAnchor.constraint(equalTo: businessImage.bottomAnchor, constant: -80),
            businessName.centerXAnchor.constraint(equalTo: businessImage.centerXAnchor),
            
            separator.topAnchor.constraint(equalTo: businessName.bottomAnchor, constant: 5),
            separator.centerXAnchor.constraint(equalTo: businessImage.centerXAnchor),
            separator.leadingAnchor.constraint(equalTo: businessName.leadingAnchor, constant: -10),
            separator.trailingAnchor.constraint(equalTo: businessName.trailingAnchor, constant: 10),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            businessCategory.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10),
            businessCategory.centerXAnchor.constraint(equalTo: businessImage.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
