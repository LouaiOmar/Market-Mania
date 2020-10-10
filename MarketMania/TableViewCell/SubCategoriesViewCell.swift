//
//  SubCategoriesViewCell.swift
//  MarketMania
//
//  Created by Louai on 9/19/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import UIKit

class SubCategoriesViewCell: UITableViewCell {

    @IBOutlet weak var subCategoryImage: UIImageView!
    @IBOutlet weak var subCategoryName: UILabel!
   let imagesForSubs: [UIImage] = [#imageLiteral(resourceName: "sub18"), #imageLiteral(resourceName: "sub13"), #imageLiteral(resourceName: "sub11"), #imageLiteral(resourceName: "sub13"), #imageLiteral(resourceName: "sub21"), #imageLiteral(resourceName: "sub51"), #imageLiteral(resourceName: "sub15"), #imageLiteral(resourceName: "sub19"), #imageLiteral(resourceName: "sub14")]

    override func awakeFromNib() {
        super.awakeFromNib()
        subCategoryImage.layer.cornerRadius = subCategoryImage.frame.height / 2
        subCategoryImage.clipsToBounds = true
    }

    func configure(_ subCategory: SubResults) {
        subCategoryImage.image = imagesForSubs[Int.random(in: 0...8)]
        subCategoryName.text = subCategory.name
        subCategoryImage.contentMode = .scaleAspectFit

    }
    
    
    
}
