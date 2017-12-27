//
//  SearchItemsService.swift
//  OLX-Challenge
//
//  Created by Daniel Mankowski on 12/26/17.
//  Copyright © 2017 Daniel Mankowski. All rights reserved.
//

import Foundation

class SearchItemsService {
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Item]?, String) -> ()
    
    fileprivate var items: [Item] = []
    fileprivate var errorMessage = ""
    
    fileprivate let defaultSession = URLSession(configuration: .default)
    fileprivate var dataTask: URLSessionDataTask?
    fileprivate let urlBase = "http://api-v2.olx.com/items"
    
    fileprivate let storageController = StorageController()
    
    func getSearchResults(searchTerm: String, pageSize:Int, offset: Int, completion: @escaping QueryResult) {
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: urlBase) {
            urlComponents.query = "location=www.olx.com.ar&searchTerm=\(searchTerm)&pageSize=\(pageSize)&offset=\(offset)"

            guard let url = urlComponents.url else { return }

            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                guard let safeSelf = self else {return}
                defer { safeSelf.dataTask = nil }

                if let error = error {
                    safeSelf.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                    safeSelf.items = safeSelf.storageController.fetchItems()
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    safeSelf.updateSearchResults(data)

                } else {
                    safeSelf.items = safeSelf.storageController.fetchItems()
                }
                
                DispatchQueue.main.async {
                    completion(safeSelf.items, safeSelf.errorMessage)
                }
            }

            dataTask?.resume()
        }
    }
    
    fileprivate func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
        items.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["data"] as? [Any] else {
            errorMessage += "Dictionary does not contain data key\n"
            return
        }
        var index = 0
        for itemDictionary in array {
            if let itemDictionary = itemDictionary as? JSONDictionary {
                items.append(Item(dictionary: itemDictionary))
                DispatchQueue.global(qos: .background).async {
                    self.storageController.save(self.items)
                }
                index += 1
            } else {
                errorMessage += "Problem parsing itemDictionary\n"
            }
        }
    }
}
