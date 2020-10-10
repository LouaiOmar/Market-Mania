//
//  TrendingViewCell.swift
//  MarketMania
//
//  Created by Louai on 9/19/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import UIKit

class TrendingViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
  
    var didSelectItemAction: ((Int) -> Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "TrendingCollectionCell", bundle: nil), forCellWithReuseIdentifier: "TrendingColCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Values.finalTrending.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingColCell", for: indexPath) as! TrendingCollectionCell
        cell.configureCells(indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAction?(indexPath.row)
    }
    
    
    
    func configure() {
    collectionView.reloadData()
   
    }
    
    
    
    
}
