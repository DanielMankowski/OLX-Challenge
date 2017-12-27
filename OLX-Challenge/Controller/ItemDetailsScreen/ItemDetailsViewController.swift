//
//  ItemDetailsViewController.swift
//  OLX-Challenge
//
//  Created by Daniel Mankowski on 12/26/17.
//  Copyright © 2017 Daniel Mankowski. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    //MARK: - Properties
    var item: Item!
    
    let imageSegue = "ItemDetailsImage"
    let dataSegue  = "ItemDetailsData"
    
    static func instantiateVC(item: Item) -> ItemDetailsViewController{
        let thisVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemDetailsViewController") as! ItemDetailsViewController
        thisVC.item = item
        
        return thisVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initContainers()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case imageSegue:
            let vc = segue.destination as! ItemDetailsImageViewController
            vc.urlImage = item.fullImage
            break
        case dataSegue:
            let vc = segue.destination as! ItemDetailsDataViewController
            vc.item = item
            break
        default:
            break
        }
    }
    
    func initContainers(){
        performSegue(withIdentifier: imageSegue, sender: nil)
        performSegue(withIdentifier: dataSegue, sender: nil)
    }

}
