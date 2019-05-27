//
//  MoviesVCDelegate.swift
//  TVGuide
//
//  Created by Fernando on 24/5/2019.
//  Copyright © 2019 Fernando. All rights reserved.
//

import UIKit

protocol ShowsVCDelegate: class {
    func networkError(error:Error)
    func updateShows(shows: [ShowsVM])
    func updateImage(image:UIImage, indexPath: IndexPath)
}
