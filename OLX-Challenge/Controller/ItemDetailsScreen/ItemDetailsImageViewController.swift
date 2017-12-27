//
//  ItemDetailsImageViewController.swift
//  OLX-Challenge
//
//  Created by Daniel Mankowski on 12/26/17.
//  Copyright © 2017 Daniel Mankowski. All rights reserved.
//

import UIKit
import Nuke

class ItemDetailsImageViewController: UIViewController {

//    MARK: - Outlets
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    var urlImage: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        if let url = URL(string: urlImage){
            Manager.shared.loadImage(with: url, into: imageView)
        }
    }

    func configureUI(){
        // Convert to circle image
        imageView.layoutIfNeeded()
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }

}
