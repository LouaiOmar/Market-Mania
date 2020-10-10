//
//  CategoryData.swift
//  MarketMania
//
//  Created by Louai on 9/18/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import Foundation

struct CategoryData: Codable {
    var categories: [ResultsList]
}

struct ResultsList: Codable {
    var id: String
    var name: String
    var subCategories: [SubResults]
}

struct SubResults: Codable {
    var id: String
    var name: String
}

struct ProductData: Codable {
    var results: [ProductResult]?
}


struct ProductResult: Codable {
    var descriptions: Description
    var images: Image
    var names: Name
    var prices: Price
}

struct Description: Codable {
    var short: String
}

struct Image: Codable {
    var standard: String
}

struct Name: Codable {
    var title: String
}

struct Price: Codable {
    var current: Float
}


struct Values {
    
    
    static var finalCategories: [ResultsList] = []
    static var finalTrending: [ProductResult] = []
    static var categoryCount: Int = 0
    static var subCategoryCount: Int = 0
    static var hasSubCategory = false

}

