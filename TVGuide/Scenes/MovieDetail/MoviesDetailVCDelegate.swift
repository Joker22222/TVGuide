//
//  MoviesDetailVCDelegate.swift
//  TVGuide
//
//  Created by Fernando on 24/5/2019.
//  Copyright © 2019 Fernando. All rights reserved.
//

import UIKit

protocol MoviesDetailVCDelegate: class {
    func networkError(error:Error)
    func loadVideo(videoId:String)
    func updateImage(image:UIImage)
}
