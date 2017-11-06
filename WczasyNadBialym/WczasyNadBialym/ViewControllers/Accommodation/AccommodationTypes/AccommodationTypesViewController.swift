//
//  AccommodationTypesViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 02.09.2016.
//  Copyright © 2016 Marek Hać. All rights reserved.
//

import UIKit

class AccommodationTypesViewController: UITableViewController {
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // blur tableview background
        
        self.tableView.addBlurSubview(image: "background_blue")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Noclegi"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.selectedBackgroundColor(UIColor(white: 1, alpha: 0.5))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AccommodationTypesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "accommodationTypesCell", for: indexPath) as! AccommodationTypeCell
        
        cell.name?.text = (AccommodationTypesArray[indexPath.row] as AccommodationType).longName
        cell.accommodationType = AccommodationTypesArray[indexPath.row] as AccommodationType
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedCell = sender as? AccommodationTypeCell {
            if let destinationVC = segue.destination as? AccommodationListViewController {
                destinationVC.accommodationType = selectedCell.accommodationType!
            }
        }
    }
}
