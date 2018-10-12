//
//  ButtonTableViewCell.swift
//  RestaurantRater
//
//  Created by Xavier on 10/11/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    
    //MARK: - Constants and Outlets
    var restaurant: Restaurant?

    
    //MARK: - Outlets
    @IBOutlet weak var isGoodButton: UIButton!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    
    @IBAction func isGoodButtonTapped(_ sender: Any) {
    }
    

}
