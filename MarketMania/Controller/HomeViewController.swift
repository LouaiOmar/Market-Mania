//
//  HomeViewController.swift
//  MarketMania
//
//  Created by Louai on 9/18/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import UIKit
import RealmSwift


class HomeViewController: UITableViewController, UpdateCategories  {

    
    @IBOutlet weak var cartBadge: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
let realm = try! Realm()
var categories = CategoriesJSON()
var trending = TrendingViewed()
var itemList: Results<Item>?
var itemRow = 0
var itemSection = 0
    


    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        categories.delegate = self
        trending.delegate = self
         categories.performRequest(with: "https://api.bestbuy.com/v1/categories?format=json&show=id,name,subCategories.name,subCategories.id&pageSize=2&apiKey=9qSnSJNvYvSAepk4BsGSqotW")
        tableView.register(UINib(nibName: "TrendingViewCell", bundle: nil), forCellReuseIdentifier: "TrendingCell")
        tableView.register(UINib(nibName: "SubCategoriesViewCell", bundle: nil), forCellReuseIdentifier: "SubCell")
       loadItems()
    }
    
     func updateCategoriesCollection() {
        if Values.finalTrending.count < Values.finalCategories.count {
            if Values.hasSubCategory {
                trending.performRequest(with: "https://api.bestbuy.com/beta/products/trendingViewed(categoryId=\(Values.finalCategories[Values.categoryCount].subCategories[Values.subCategoryCount].id))?format=json&apiKey=9qSnSJNvYvSAepk4BsGSqotW")
            } else {
                trending.performRequest(with: "https://api.bestbuy.com/beta/products/trendingViewed(categoryId=\(Values.finalCategories[Values.categoryCount].id))?format=json&apiKey=9qSnSJNvYvSAepk4BsGSqotW")
                }
        }
        if Values.finalTrending.count == Values.finalCategories.count {
            DispatchQueue.main.async{
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    

    func updateCartBadge() {
        itemList = realm.objects(Item.self)
        self.cartBadge.updateBadge(number: self.itemList?.count ?? 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        updateCartBadge()
    }
    
    

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Values.finalCategories.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
          
            return Values.finalCategories[section - 1].subCategories.count
        
        }
        
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell", for: indexPath) as! TrendingViewCell
           cell.configure()
           cell.didSelectItemAction = { [weak self] indexPath in
               self?.itemRow = indexPath
               self?.performSegue(withIdentifier: "goToDetails", sender: self)
           }
        return cell
        } else {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SubCell", for: indexPath) as! SubCategoriesViewCell
            cell.configure(Values.finalCategories[indexPath.section - 1].subCategories[indexPath.row])
        return cell
    
    }
    
}
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//         switch section {
//         case 0:
//             return "Trending Products"
//         default:
//             return Values.finalCategories[section - 1].name
//         }
//    }
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else {
            return 100
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.width - 15, height: 40))
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if section == 0 {
            label.text = "Trending Products"
        } else {
            label.text = Values.finalCategories[section - 1].name
        }
        label.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemRow = indexPath.row
        itemSection = indexPath.section
        performSegue(withIdentifier: "goToList", sender: self)
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 15))
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToList" {
        let destinationVC = segue.destination as! SubCategoryListViewController
        destinationVC.subCategoryProducts.performRequest(with: "https://api.bestbuy.com/beta/products/mostViewed(categoryId=\(Values.finalCategories[itemSection - 1].subCategories[itemRow].id))?format=json&apiKey=9qSnSJNvYvSAepk4BsGSqotW")
        destinationVC.labelText = Values.finalCategories[itemSection - 1].subCategories[itemRow].name
    } else if segue.identifier == "goToDetails" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.productDetails.removeAll()
            destinationVC.productDetails.append(Values.finalTrending[itemRow])

        }
    }


}

//MARK:-

extension HomeViewController {
    
    func loadItems() {
        itemList = realm.objects(Item.self)
        
    }
    
    override func viewDidLayoutSubviews() {
                  if let safeItemList = itemList {
                      cartBadge.addBadge(number: safeItemList.count)
                  } else {
                      cartBadge.addBadge(number: 0)
                  }
        
    }

}
