//
//  ExploreView.swift
//  BiteSight
//
//  Created by (Vincent) GuoWei Li on 11/22/23.
//

import UIKit
import Koloda

class ExploreView: UIView {

    var kolodaView: KolodaView!
    var dislikeButton: UIButton!
    var likeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        kolodaView = KolodaView()
        kolodaView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(kolodaView)
        
        dislikeButton = UIButton()
        dislikeButton.setImage(UIImage(named: "dislike"), for: .normal)
        dislikeButton.layer.cornerRadius = 30
        dislikeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dislikeButton)
        
        likeButton = UIButton()
        likeButton.setImage(UIImage(named: "like"), for: .normal)
        likeButton.layer.cornerRadius = 30
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            kolodaView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: -50),
            kolodaView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            kolodaView.widthAnchor.constraint(equalToConstant: 360),  // Assuming a fixed width
            kolodaView.heightAnchor.constraint(equalToConstant: 530),  // Assuming a fixed height
            
            dislikeButton.topAnchor.constraint(equalTo: kolodaView.bottomAnchor, constant: 60),
            dislikeButton.leadingAnchor.constraint(equalTo: kolodaView.leadingAnchor, constant: 15),
            dislikeButton.widthAnchor.constraint(equalToConstant: 60),
            dislikeButton.heightAnchor.constraint(equalToConstant: 60),
            
            likeButton.topAnchor.constraint(equalTo: kolodaView.bottomAnchor, constant: 60),
            likeButton.trailingAnchor.constraint(equalTo: kolodaView.trailingAnchor, constant: -15),
            likeButton.widthAnchor.constraint(equalToConstant: 60),
            likeButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
