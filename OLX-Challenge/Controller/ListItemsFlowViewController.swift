//
//  ListItemsFlowViewController.swift
//  OLX-Challenge
//
//  Created by Daniel Mankowski on 12/26/17.
//  Copyright © 2017 Daniel Mankowski. All rights reserved.
//

import UIKit

class ListItemsFlowViewController: UIViewController {
    
    //MARK: - Properties
    var navigation: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        let listVC = ListItemsViewController.instantiateVC(delegate: self)
        navigation = UINavigationController(rootViewController: listVC)
        if let nav = navigation {
            present(nav, animated: false, completion: nil)
        }
    }
}

extension ListItemsFlowViewController: ListItemsDelegate {
    func itemWasPressed(item: Item) {
        let detailVC = ItemDetailsViewController.instantiateVC(item: item)
        navigation?.pushViewController(detailVC, animated: true)
    }
}
