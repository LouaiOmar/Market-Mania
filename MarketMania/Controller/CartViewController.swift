//
//  CartViewController.swift
//  MarketMania
//
//  Created by Louai on 10/1/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit


class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwipeTableViewCellDelegate {

 
    @IBOutlet weak var todayDate: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
   
    let realm = try! Realm()
    var itemList: Results<Item>?
    
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
        todayDate.text = changeDateFormat()
        updateTotalPrice()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     tableView.register(UINib(nibName: "CartTableCell", bundle: nil), forCellReuseIdentifier: "CartCell")       
    }
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList?.count ?? 0
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var unitPrice: Float = 0
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as! CartTableCell
        cell.delegate = self
        if let safeItem = itemList {
                cell.configure(safeItem[indexPath.row])
        }
        cell.plusButtonTapped = {
            print(indexPath.row)
            if let item = self.itemList?[indexPath.row] {
                                do {
                                    try  self.realm.write {
                                    item.numberOfPieces += 1
                                    }
                                    unitPrice = Float(item.numberOfPieces) * item.price
                                    cell.configureLabels(item.numberOfPieces, unitPrice)
                                    self.updateTotalPrice()
                                } catch {
                                    print(error)
                                }
                            }
        }
        cell.minusButtonTapped = {
            if let item = self.itemList?[indexPath.row] {
                    do {
                        try  self.realm.write {
                        item.numberOfPieces -= 1
                    }
                    } catch {
                        print(error)
                    }
                if item.numberOfPieces == 0 {
                     do {
                        try  self.realm.write {
                        self.realm.delete(item)
                        }
                        } catch {
                        print(error)
                }
                    self.loadItems()
                } else {
                unitPrice = Float(item.numberOfPieces) * item.price
                cell.configureLabels(item.numberOfPieces, unitPrice)
                    }
                self.updateTotalPrice()
                }
        }
                return cell
     }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
                let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
        self.deleteSelectedRow(at: indexPath)
        }
        deleteAction.image = UIImage(named: "Trash")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
           var options = SwipeOptions()
           options.expansionStyle = .destructive
           return options
       }
       
    
    func deleteSelectedRow(at indexPath: IndexPath) {
        if let item = self.itemList?[indexPath.row] {
                 do {
                    try  self.realm.write {
                    self.realm.delete(item)
                    }
                    } catch {
                    print(error)
            }
                self.updateTotalPrice()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


  
    

}
//MARK:-
//Date Format

extension CartViewController {
   
    func changeDateFormat() -> String {
    let today = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM y"
    return formatter.string(from: today)
    }

    func loadItems() {
        itemList = realm.objects(Item.self)
        tableView.reloadData()
    }
    
    func updateTotalPrice() {
       itemList = realm.objects(Item.self)
        var totalPriceCalculated: Float = 0
        var totalPriceString =  ""
        if let safeItemList = itemList {
            totalPriceCalculated = safeItemList.map({$0.price * Float($0.numberOfPieces)}).reduce(0.0, +)
            totalPriceString = String(format: "%.02f", totalPriceCalculated)
            totalPrice.text = "Total Price:     $ \(totalPriceString)"
        } else {
            totalPrice.text = "Total Price:     $ 0.0"
        }
    }
}
