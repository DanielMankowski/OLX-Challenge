//
//  ItemDetailsDataViewController.swift
//  OLX-Challenge
//
//  Created by Daniel Mankowski on 12/26/17.
//  Copyright © 2017 Daniel Mankowski. All rights reserved.
//

import UIKit

class ItemDetailsDataViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var locationLabel: UILabel!
    @IBOutlet fileprivate weak var priceLabel: UILabel!
    
    //MARK: - Properties
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI(){
        descriptionLabel.text = item.description
        locationLabel.text    = item.displayLocation
        priceLabel.text       = item.displayPrice
    }
}
