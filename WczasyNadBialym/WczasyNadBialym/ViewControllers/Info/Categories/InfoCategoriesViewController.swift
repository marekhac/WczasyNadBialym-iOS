//
//  InfoCategoriesViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 16.05.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit

class InfoCategoriesViewController: UITableViewController {

    struct InfoCategory {
        var category : InfoCategoriesEnum
        var longName : String
    }
    
    let infoCategories = [InfoCategory(category: .lake, longName: "O Jezioro Białym"),
                          InfoCategory(category: .essentials, longName: "Warto wiedzieć")]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // blur tableview background
        
        self.tableView.addBlurSubview(image: "background_green")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.infoCategories.count
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.selectedBackgroundColor(UIColor(white: 1, alpha: 0.5))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCategoriesCell", for: indexPath) as! InfoCategoriesCell
        
        cell.name?.text = (self.infoCategories[indexPath.row] as InfoCategory).longName
        cell.selectedCategory = (self.infoCategories[indexPath.row] as InfoCategory).category
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! InfoCategoriesCell
        let controller = segue.destination as! InfoDetailsViewController
        controller.category = cell.selectedCategory
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (indexPath.row)
    }
}
