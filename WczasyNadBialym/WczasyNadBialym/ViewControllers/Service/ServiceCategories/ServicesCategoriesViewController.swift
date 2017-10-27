//
//  ServicesTypesViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 24.04.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit

class ServicesCategoriesViewController: UITableViewController {

    var serviceCategories = [ServiceCategoryModel]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.serviceCategories = generateServiceCategories()
        
        /* services can also be downloaded using API */

//        NetworkManager.sharedInstance().getServiceCategories { (serviceCategoriesDict, error) in
//            self.serviceCategories = serviceCategoriesDict
//            OperationQueue.main.addOperation({
//                self.tableView.reloadData()
//            })
//        }
    }

    func generateServiceCategories() -> [ServiceCategoryModel] {
        
        let categories = [ServiceCategoryModel(shortName: "apteka", longName: "Apteki"),
                          ServiceCategoryModel(shortName: "opieka_medyczna", longName: "Opieka medyczna"),
                          ServiceCategoryModel(shortName: "bankomat", longName: "Bankomaty"),
                          ServiceCategoryModel(shortName: "bank", longName: "Banki"),
                          ServiceCategoryModel(shortName: "kosciol", longName: "Kościoły"),
                          ServiceCategoryModel(shortName: "urzedy", longName: "Urzędy i instytucje"),
                          ServiceCategoryModel(shortName: "poczta", longName: "Urzędy Pocztowe"),
                          ServiceCategoryModel(shortName: "hot_spot", longName: "Hot-Spoty"),
                          ServiceCategoryModel(shortName: "wc", longName: "WC"),
                          ServiceCategoryModel(shortName: "stacja_paliw", longName: "Stacje Paliw"),
                          ServiceCategoryModel(shortName: "warsztaty_samoch", longName: "Warsztaty i pomoc drogowa")]

        return categories
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.serviceCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCategoryCell", for: indexPath) as! ServiceCategoryCell
        
        cell.name?.text = (self.serviceCategories[indexPath.row] as ServiceCategoryModel).longName
        cell.shortName = (self.serviceCategories[indexPath.row] as ServiceCategoryModel).shortName
               
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedCell = sender as? ServiceCategoryCell {
            if let destinationVC = segue.destination as? ServiceListViewController {
                destinationVC.serviceTypeName = selectedCell.shortName
            }
        }
    }
}
