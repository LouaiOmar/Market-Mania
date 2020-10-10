//
//  DetailsCollectionCell.swift
//  MarketMania
//
//  Created by Louai on 9/21/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import UIKit

class ListCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    var cartButtonIsTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buyButton.layer.cornerRadius = buyButton.frame.size.width / 2
        buyButton.layer.borderColor = UIColor.red.cgColor
        buyButton.layer.borderWidth = 2
    }

    func configureCells(_ data: ProductResult) {
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: UIControl.Event.touchUpInside)
        productLabel.text = data.names.title
        let url = URL(string: data.images.standard)
              if let safeurl = url {
                if let data = try? Data(contentsOf: safeurl) {
                    productImage.image = UIImage(data: data)
                    productImage.contentMode = .scaleAspectFit
                }
          }
      }
    
  @IBAction func buyButtonTapped() -> Void {
         let alert = UIAlertController(title: "Added to the Cart", message: "This item has been added Sucssefully to the Cart", preferredStyle: .alert)
               
         let action = UIAlertAction(title: "Done", style: .default) { (action) in
                   //what will happen once the user clicks the Add Item button on our UIAlert
            self.cartButtonIsTapped?()
        }
        
        alert.addAction(action)
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    
    
}
