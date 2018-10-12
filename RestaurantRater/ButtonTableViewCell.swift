//
//  ButtonTableViewCell.swift
//  RestaurantRater
//
//  Created by Xavier on 10/11/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

// Step 1 declare our delegate protocol- if you say you're a delegate you have to do this stuff
protocol ButtonTableViewCellDelegate: class {
    
    func isGoodToggled(sender: ButtonTableViewCell)
    
}

class ButtonTableViewCell: UITableViewCell {
    
    
    //MARK: - Constants and Outlets
    var restaurant: Restaurant? {
        didSet{
            updateViews()
        }
    }
    
    //Step 2 - Declare a delegate property - allow something to set it ourself our delegate
    weak var delegate: ButtonTableViewCellDelegate?

    
    //MARK: - Outlets
    @IBOutlet weak var isGoodButton: UIButton!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    
    @IBAction func isGoodButtonTapped(_ sender: Any) {
        
        // Step 3 - Notify the delgate that an event happened/ call that delegate functions
        delegate?.isGoodToggled(sender: self)
    }
    
    func updateViews() {
        guard let restaurant = restaurant else { return}
        
        restaurantNameLabel.text = restaurant.name
        
        if restaurant.isGood == true {
            isGoodButton.setImage(#imageLiteral(resourceName: "thumbs-up"), for: .normal)
        }else {
            isGoodButton.setImage(#imageLiteral(resourceName: "thumbs-down.png"), for: .normal)
        }
    }
}

