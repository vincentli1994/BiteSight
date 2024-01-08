//
//  Restaurant.swift
//  BiteSight
//
//  Created by Tiffany Zhang on 11/26/23.
//

import Foundation

struct Restaurant: Codable {
    var docId: String?
    
    var id: String?
    var name: String?
    var category: String?
    var imageUrl: String?
    var price: String?
    var rating: Int?
    var reviewCount: Int?
    
    var address: String?
    var city: String?
    var state: String?
    var country: String?
    var zipCode: String?
    var displayAddress: [String]?
    var displayPhone: String?
    
    var distance: Double?
    var latitude: Double?
    var longtitude: Double?
}

struct BusinessSearch: Codable {
    var businesses: [Business]?
    var total: Int?
    var region: Region?
}

struct Region: Codable {
    var center: Coordinate?
}

struct Coordinate: Codable {
    var latitude: Double?
    var longitude: Double?
}

struct Business: Codable {
    var id: String?
    var name: String?
    var imageUrl: String?
    var url: String?
    var reviewCount: Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinate?
    var price: String?
    var location: Location?
    var displayPhone: String?
    var distance: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
        case url
        case reviewCount = "review_count"
        case categories
        case rating
        case coordinates
        case price
        case location
        case displayPhone = "display_phone"
        case distance
    }
}

struct Category: Codable {
    var alias: String?
    var title: String?
}

struct Location: Codable {
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zipCode: String?
    var country: String?
    var state: String?
    var displayAddress: [String]?

    enum CodingKeys: String, CodingKey {
        case address1
        case address2
        case address3
        case city
        case zipCode = "zip_code"
        case country
        case state
        case displayAddress = "display_address"
    }
}


