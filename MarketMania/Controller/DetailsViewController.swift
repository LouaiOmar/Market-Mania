//
//  DetailsViewController.swift
//  MarketMania
//
//  Created by Louai on 9/25/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  
    @IBOutlet weak var cartBadge: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var productDetails = [ProductResult]()
    let realm = try! Realm()
    var itemList: Results<Item>?

    override func viewDidLayoutSubviews() {
        if let safeItemList = itemList {
                cartBadge.addBadge(number: safeItemList.count)
        } else {
                cartBadge.addBadge(number: 0)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ImageViewCell", bundle: nil), forCellReuseIdentifier: "ImageCell")
       tableView.register(UINib(nibName: "DescriptionViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        loadItems()
    }

    // MARK: - Table view data source

    

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageViewCell
            cell.configure(productDetails[0].images.standard)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionViewCell
            cell.configure(productDetails[0])
            cell.cartButtonIsTapped = {
                self.checkAndSaveNewItem(indexPath)
            }
                       return cell
        }
        
    }
  
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 400
        }
 

}

//MARK:-

extension DetailsViewController {
    
    func loadItems() {
        itemList = realm.objects(Item.self)
        
    }
    
    func updateCartBadge() {
          itemList = realm.objects(Item.self)
          self.cartBadge.updateBadge(number: self.itemList?.count ?? 0)
      }

    func checkAndSaveNewItem(_ indexPath: IndexPath) {
    let  newItemCheck = self.itemList?.filter("name == %@", self.productDetails[0].names.title)
    
      if newItemCheck?.count == 0 {
          let newItem = Item()
           newItem.image = self.productDetails[0].images.standard
           newItem.name = self.productDetails[0].names.title
           newItem.price = self.productDetails[0].prices.current
           do {
               try self.realm.write {
                   self.realm.add(newItem)
                          }
                      } catch {
                       print(error.localizedDescription)
                      }
           self.updateCartBadge()
      } else {
          do {
          try self.realm.write {
              newItemCheck![0].numberOfPieces += 1
              }
          } catch {
          print(error.localizedDescription)
          }
      }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateCartBadge()
    }
    
    
}
