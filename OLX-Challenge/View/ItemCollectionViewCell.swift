//
//  ItemCollectionViewCell.swift
//  OLX-Challenge
//
//  Created by Daniel Mankowski on 12/26/17.
//  Copyright © 2017 Daniel Mankowski. All rights reserved.
//

import Foundation
import UIKit

class ItemCollectionViewCell: UICollectionViewCell{
    
    //MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet fileprivate  weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var priceLabel: UILabel!
    
    //MARK: - Properties
    var urlImage: String!
    
    var model: Model? {
        didSet {
            guard let model = model else {
                return
            }
            titleLabel.text = model.title
            priceLabel.text = model.displayPrice
            imageView.image = nil
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Set shadow to collection card
        self.layer.shadowRadius = 4.0
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.layer.masksToBounds = true
    }
    
}

extension ItemCollectionViewCell {
    struct Model {
        let urlImage: String
        let title: String
        let displayPrice: String
        
        init(item: Item) {
            urlImage = item.fullImage
            title = item.title
            displayPrice = item.displayPrice
        }
    }
}
