//
//  Item.swift
//  MarketMania
//
//  Created by Louai on 9/29/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var image = ""
    @objc dynamic var name = ""
    @objc dynamic var price: Float = 0
    @objc dynamic var numberOfPieces: Int = 1
}
