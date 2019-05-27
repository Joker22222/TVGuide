//
//  VideosMovie.swift
//  TVGuide
//
//  Created by Fernando on 23/5/2019.
//  Copyright © 2019 Fernando. All rights reserved.
//

import Foundation

public struct VideosMovieResult: Codable {
    let id: Int
    let results: [VideoMovie]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case results
    }
}

public struct VideoMovie: Codable {
    let id: String
    let iso_639_1: String
    let iso_3166_1: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case iso_639_1
        case iso_3166_1
        case key
        case name
        case site
        case size
        case type
    }
}
