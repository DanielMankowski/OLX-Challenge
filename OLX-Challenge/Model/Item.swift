//
//  Item.swift
//  OLX-Challenge
//
//  Created by Daniel Mankowski on 12/26/17.
//  Copyright © 2017 Daniel Mankowski. All rights reserved.
//

import Foundation

//Structs have value semantic, I preffer used that in order to prevent unexpected bugs
struct Item {
    let id: Double
    let description: String
    let displayPrice: String
    let amount: Float // In a real app that deals with money avoid to use float (rounding errors)
    fileprivate let normalTitle: String
    fileprivate let customTitle: String
    let displayLocation: String
    let fullImage: String
    let mediumImage: String
    
    var title: String {
        guard customTitle.isEmpty else { return customTitle }
        return normalTitle
    }
}

extension Item {
    init(dictionary: [String:Any]) {
        id = dictionary["id"] as? Double ?? 0
        description = dictionary["description"] as? String ?? ""
        normalTitle = dictionary["title"] as? String ?? ""
        customTitle = dictionary["titleCustom"] as? String ?? ""
        displayLocation = dictionary["displayLocation"] as? String ?? ""
        fullImage = dictionary["fullImage"] as? String ?? ""
        mediumImage = dictionary["mediumImage"] as? String ?? ""
        
        if let priceData = dictionary["price"] as?[String:Any] {
            displayPrice = priceData["displayPrice"] as? String ?? ""
            amount = priceData["amount"] as? Float ?? 0
        } else {
            displayPrice = dictionary["displayPrice"] as? String ?? ""
            amount = dictionary["amount"] as? Float ?? 0
        }
    }
    
    var dictionaryRepresentation: [String:Any] {
        return [
            "id": id as Any,
            "description": description as Any,
            "displayPrice": displayPrice as Any,
            "amount": amount as Any,
            "title": normalTitle as Any,
            "titleCustom": customTitle as Any,
            "displayLocation": displayLocation as Any,
            "fullImage": fullImage as Any,
            "mediumImage": mediumImage as Any
        ]
    }
}
