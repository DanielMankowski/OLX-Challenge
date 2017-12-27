//
//  StorageController.swift
//  OLX-Challenge
//
//  Created by Daniel Mankowski on 26/12/2017.
//  Copyright © 2017 Daniel Mankowski. All rights reserved.
//

import Foundation

class StorageController {
    fileprivate let documentsDirectoryURL = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
    
    fileprivate var itemsFileURL: URL {
        return documentsDirectoryURL
            .appendingPathComponent("Items")
            .appendingPathExtension("plist")
    }
    
    func save(_ items: [Item]) {
        let itemsPlist = items.map { $0.dictionaryRepresentation } as NSArray
        itemsPlist.write(to: itemsFileURL, atomically: true)
    }
    
    func fetchItems() -> [Item] {
        guard let itemPlists = NSArray(contentsOf: itemsFileURL) as? [[String: Any]] else {
            return []
        }
        return itemPlists.map(Item.init(dictionary:))
    }
}
