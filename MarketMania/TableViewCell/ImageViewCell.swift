//
//  ImageViewCell.swift
//  MarketMania
//
//  Created by Louai on 9/25/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import UIKit

class ImageViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func configure(_ imageString: String) {
         let url = URL(string: imageString)
             if let safeurl = url {
               if let data = try? Data(contentsOf: safeurl) {
                   productImage.image = UIImage(data: data)
                   productImage.contentMode = .scaleAspectFit
               }
         }

     }
    
}
