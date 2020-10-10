//
//  CartTableCell.swift
//  MarketMania
//
//  Created by Louai on 9/26/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import UIKit
import SwipeCellKit

class CartTableCell :SwipeTableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var plusButton: PushButton!
    @IBOutlet weak var minusButton: PushButton!
    
    
    var plusButtonTapped: (() -> Void)?
    var minusButtonTapped: (() -> Void)?




  
    func configure(_ product: Item) {
        plusButton.addTarget(self, action: #selector(plusButtonPressed), for: UIControl.Event.touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonPressed), for: UIControl.Event.touchUpInside)
        let url = URL(string: product.image)
                   if let safeurl = url {
                     if let data = try? Data(contentsOf: safeurl) {
                         productImage.image = UIImage(data: data)
                         productImage.contentMode = .scaleAspectFit
                     }
               }
        productName.text = product.name
        productCount.text = String(product.numberOfPieces)
        productPrice.text = String(product.price * Float(product.numberOfPieces))
        }
        
    
    

    @IBAction func plusButtonPressed() -> Void {
        plusButtonTapped?()
    }
    
    func configureLabels(_ pieces: Int,_ price: Float) {
        productCount.text = String(pieces)
        productPrice.text = String(price)
    }
    
    @IBAction func minusButtonPressed() -> Void {
            minusButtonTapped?()
    }

}
    
    


