//
//  SearchCell.swift
//  TVGuide
//
//  Created by Fernando on 25/5/2019.
//  Copyright © 2019 Fernando. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    
    func configWitItem(_ item: Item) {
        self.selectionStyle = .none
        self.titleLbl.text = item.title
        self.descriptionLbl.text = item.overview
        self.dateLbl.text = item.releaseDate
        if let image = item.posterImage {
            thumbnailView.image = image
        } else {
            thumbnailView.image = UIImage(named: "placeholder")
        }
    }
}
