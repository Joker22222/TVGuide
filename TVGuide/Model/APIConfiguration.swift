//
//  APIConfiguration.swift
//  TVGuide
//
//  Created by Fernando on 22/5/2019.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Foundation

public struct APIConfiguration: Codable {
    let images: APIImageConfiguration
    let changeKeys: [String]
    
    private enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }
}

public struct APIImageConfiguration: Codable {
    let baseUrl: String
    let secureBaseUrl: String
    let backdropSizes: [String]
    let logoSizes: [String]
    let posterSizes: [String]
    let profileSizes: [String]
    let stillSizes: [String]
    
    private enum CodingKeys: String, CodingKey {
        case baseUrl = "base_url"
        case secureBaseUrl = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
}
