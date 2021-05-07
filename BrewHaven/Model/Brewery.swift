//
//  Brewery.swift
//  BrewHaven
//
//  Created by Devin on 4/20/21.
//

import Foundation

struct Brewery: Codable {
    let name: String
    let breweryType: String
    let street: String
    let city: String
    let state: String
    let country: String
    let website: String
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case breweryType = "brewery_type"
        case street
        case city
        case state
        case country
        case website = "website_url"
    }
}//End of Struct

