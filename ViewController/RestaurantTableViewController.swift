//
//  RestaurantTableViewController.swift
//  RestaurantRater
//
//  Created by Xavier on 10/11/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        RestaurantController.sharedInstance.fetchResultsController.delegate = self
        
    }
    

    @IBAction func addRestaurantButtonTapped(_ sender: Any) {
        
        //Instance of Alert controller
        let alertController = UIAlertController(title: "Add a new restaurant", message: "Enter restaurant name below", preferredStyle: .alert)
        
        //This code actually determines the configuration of the textField/ Caled a configuration handler, important that yoi add the configuration textField handler right after you create the instance of alert.
        alertController.addTextField { (textField) in
            textField.placeholder = "Restaurant Name"
        }
        
        // we defined what was fgoing to go on the action button, then we told it what style it was going to be (default)
        let createAction = UIAlertAction(title: "Create", style: .default) { (_) in
            
            guard let name = alertController.textFields?[0].text,!name.isEmpty
                else { return}
            
            RestaurantController.sharedInstance.addRestaurant(name: name)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(createAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    

    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return RestaurantController.sharedInstance.restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as? ButtonTableViewCell else { return UITableViewCell()}

        // Configure the cell...
        let restaurant = RestaurantController.sharedInstance.restaurants[indexPath.row]
        
        // We need to send a restauranty to the didSet or to our landing pad. The didset is just waiting for it to land so it can update the button and the rest of the view
        cell.restaurant = restaurant
        
        // step 3- Set ourself as the delegate
        cell.delegate = self

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let restaurantToDelete = RestaurantController.sharedInstance.restaurants[indexPath.row]
        
        RestaurantController.sharedInstance.delete(restaurant: restaurantToDelete)
    }

}

// step 1 - Adopt the protocol delegate, and said that we are a delegate, not we have to do what the delgate does to actaul say we are a delegate.
extension RestaurantTableViewController: ButtonTableViewCellDelegate {
    func isGoodToggled(sender: ButtonTableViewCell) {
        guard let restaurant = sender.restaurant else { return}
        RestaurantController.sharedInstance.toggleIsGood(for: restaurant)
        sender.updateViews()
    }
}

extension RestaurantTableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
