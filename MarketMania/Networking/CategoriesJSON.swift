//
//  CategoriesJSON.swift
//  MarketMania
//
//  Created by Louai on 9/18/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import Foundation

class CategoriesJSON{
    
    
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
            let decodeData = try decoder.decode(CategoryData.self, from: upcomingData)
                self.dispatchQueue(decodeData)
        } catch {
            print(error)
        }
    }
 
    func dispatchQueue(_ decodeData: CategoryData) {
        Values.finalCategories = decodeData.categories
        Values.finalCategories = Values.finalCategories.filter { $0.subCategories.count != 0 }
        self.delegate?.updateCategoriesCollection()
    }
    


}
