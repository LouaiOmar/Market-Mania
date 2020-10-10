//
//  TrendingViewed.swift
//  MarketMania
//
//  Created by Louai on 9/18/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import Foundation

class TrendingViewed {


    var delegate: UpdateCategories?
    
    func performRequest(with upcomingURL: String) {
    let url = URL(string: upcomingURL)
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url!) { (data, response, error) in
    if error != nil {
        print(error!)
        return
    }
        self.parseJSON(data!)
    }
    task.resume()
}

     func parseJSON(_ upcomingData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(ProductData.self, from: upcomingData)
            
                self.dispatchQueue(decodeData)
            
        } catch {
            print(error)
        }
    }

    func dispatchQueue(_ decodeData: ProductData) {
        if Values.hasSubCategory {
                if decodeData.results?.count == 0 {
                Values.finalCategories[Values.categoryCount].subCategories = Values.finalCategories[Values.categoryCount].subCategories.filter{ $0.id != Values.finalCategories[Values.categoryCount].subCategories[Values.subCategoryCount].id}
                        if Values.finalCategories[Values.categoryCount].subCategories.count == 0 {
                        Values.finalCategories = Values.finalCategories.filter{ $0.id != Values.finalCategories[Values.categoryCount].id}
                        Values.categoryCount = 0
                        Values.hasSubCategory = false
                        } else {
                            Values.subCategoryCount = 0
                        }
                } else {
                        if Values.finalCategories[Values.categoryCount].subCategories.count - 1 > Values.subCategoryCount {
                       Values.subCategoryCount += 1
                        } else {
                        Values.subCategoryCount = 0
                        Values.hasSubCategory = false
                                if let safeData = decodeData.results?[2] {
                                Values.finalTrending.append(safeData)
                                Values.categoryCount += 1
                                }
                          
                        self.delegate?.updateCategoriesCollection()
                            return
                        }
                }
        } else {
                if decodeData.results?.count == 0 {
                Values.finalCategories = Values.finalCategories.filter{ $0.id != Values.finalCategories[Values.categoryCount].id}
                        Values.categoryCount = 0
                } else {
                            Values.hasSubCategory = true
                                }
                          
                        }
            
        print("\(Values.categoryCount) category count value")
        print("\(Values.subCategoryCount) subcategory count value")
        print("\(Values.finalCategories[Values.categoryCount].subCategories.count) the count of subcatogeries")
        self.delegate?.updateCategoriesCollection()
    }
        
        
        


}
