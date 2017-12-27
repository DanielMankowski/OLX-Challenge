//
//  ListItemsViewController+SearchBarDelegate.swift
//  OLX-Challenge
//
//  Created by Daniel Mankowski on 12/26/17.
//  Copyright © 2017 Daniel Mankowski. All rights reserved.
//

import Foundation
import UIKit

extension ListItemsViewController: UISearchBarDelegate {
    
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        searchResults.removeAll()
        loadItems(term: searchText, pageSize: initialPageSize, offset: 0)
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapRecognizer)
    }
    
}
