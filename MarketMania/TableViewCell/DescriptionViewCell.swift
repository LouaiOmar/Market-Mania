//
//  DescriptionViewCell.swift
//  MarketMania
//
//  Created by Louai on 9/25/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import UIKit

class DescriptionViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    
    var cartButtonIsTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(_ data: ProductResult) {
       cartButton.addTarget(self, action: #selector(cartButtonTapped), for: UIControl.Event.touchUpInside)
        productName.text = data.names.title
        productPrice.text = String(data.prices.current)
        productDescription.text = data.descriptions.short

       }
    
    @IBAction func cartButtonTapped() -> Void {
          let alert = UIAlertController(title: "Added to the Cart", message: "This item has been added Sucssefully to the Cart", preferredStyle: .alert)
                 
           let action = UIAlertAction(title: "Done", style: .default) { (action) in
                     //what will happen once the user clicks the Add Item button on our UIAlert
                self.cartButtonIsTapped?()
                 }
          
          alert.addAction(action)
          self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }



}
