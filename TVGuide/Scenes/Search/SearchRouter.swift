//
//  SearchRouter.swift
//  TVGuide
//
//  Created by Fernando on 25/5/2019.
//  Copyright © 2019 Fernando. All rights reserved.
//

import UIKit

protocol SearchRouterInput {
    func navigateToMovieDetail(_ model: Item)
    func navigateToShowDetail(_ model: Item)
}

class SearchRouter: SearchRouterInput {
    weak var viewController: SearchVC!
    
    // MARK: Navigation
    
    func navigateToMovieDetail(_ model: Item) {
        let storyboard = UIStoryboard(name: "MovieDetailVC", bundle: nil)
        let detailViewController = storyboard.instantiateInitialViewController()! as? MovieDetailVC
        
        detailViewController!.movie = MoviesVM(item:model)
        viewController.navigationController?.pushViewController(detailViewController!, animated: true)
    }
    
    func navigateToShowDetail(_ model: Item) {
        let storyboard = UIStoryboard(name: "ShowsDetailVC", bundle: nil)
        let detailViewController = storyboard.instantiateInitialViewController()! as? ShowsDetailVC
        
        detailViewController!.show = ShowsVM(item:model)
        viewController.navigationController?.pushViewController(detailViewController!, animated: true)
    }
}
