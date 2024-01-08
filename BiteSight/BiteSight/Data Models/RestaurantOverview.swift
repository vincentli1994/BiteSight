//
//  RestaurantOverview.swift
//  BiteSight
//
//  Created by Tiffany Zhang on 11/26/23.
//

import UIKit
import Foundation

struct RestaurantOverview {
//    @DocumentID var id: String?
    var photo: UIImage
    var name: String
    var description: String
    
    init(photo: UIImage, name: String, description: String) {
        self.photo = photo
        self.name = name
        self.description = description
    }
}
