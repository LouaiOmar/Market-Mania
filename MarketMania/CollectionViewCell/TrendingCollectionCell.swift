//
//  TrendingCollectionCell.swift
//  MarketMania
//
//  Created by Louai on 9/19/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import UIKit

class TrendingCollectionCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCells(_ index: Int) {
        productName.text = Values.finalTrending[index].names.title
        let url = URL(string: Values.finalTrending[index].images.standard)
            if let safeurl = url {
            let data = try? Data(contentsOf: safeurl)
            productImage.image = UIImage(data: data!)
            productImage.contentMode = .scaleAspectFit
            
        }
        
        
    }
    
    
    
}
