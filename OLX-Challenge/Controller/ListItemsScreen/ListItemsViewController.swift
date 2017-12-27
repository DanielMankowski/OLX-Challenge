//
//  ListItemsViewController.swift
//  OLX-Challenge
//
//  Created by Daniel Mankowski on 12/26/17.
//  Copyright © 2017 Daniel Mankowski. All rights reserved.
//

import UIKit
import Nuke

protocol ListItemsDelegate {
    func itemWasPressed(item: Item)
}

class ListItemsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Properties
    var delegate: ListItemsDelegate!
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        return recognizer
    }()
    
    var searchResults: [Item] = []
    fileprivate let searchItemsService = SearchItemsService()
    fileprivate var refresher:UIRefreshControl!
    
    fileprivate let reuseIdentifier = "ItemCollectionViewCell"
    fileprivate static let listItemsVC = "ListItemsViewController"
    fileprivate var isLoading = false
    let initialPageSize = 20
    fileprivate let sectionInsets = UIEdgeInsets(top: 8.0, left: 10.0, bottom: 8.0, right: 10.0)
    fileprivate var itemsPerRow: CGFloat {
        if UIDevice.current.orientation.isLandscape {
            return 3
        } else { // Portrait orientation
            return 2
        }
    }
    
    static func instantiateVC(delegate: ListItemsDelegate) -> ListItemsViewController{
        let thisVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: listItemsVC) as! ListItemsViewController
        thisVC.delegate = delegate
        
        return thisVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        loadItems(pageSize: initialPageSize, offset: 0)
        configureUI()
    }
    
    func loadItems(term: String = "", pageSize: Int, offset: Int, removeOldData: Bool = false){
        isLoading = true
        searchItemsService.getSearchResults(searchTerm: term, pageSize: pageSize, offset: offset) { [weak self] results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard let safeSelf = self else { return }
            safeSelf.isLoading = false
            if let results = results {
                if removeOldData { safeSelf.searchResults.removeAll() }
                if errorMessage.isEmpty {
                    safeSelf.searchResults.append(contentsOf: results)
                } else {
                    safeSelf.searchResults = results
                }
                safeSelf.collectionView.reloadData()
                safeSelf.refresher.endRefreshing()
            }
            if !errorMessage.isEmpty { print("Search error: " + errorMessage) }
        }
    }
    
    @objc func refreshData(){
        let term = searchBar.text ?? ""
        loadItems(term: term, pageSize: initialPageSize, offset: 0, removeOldData: true)
    }
    
    func configureUI(){
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.olxGreen
        self.refresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.collectionView.addSubview(refresher)
    }
    
    func checkIfPrefetchData(index: Int){
        //Pre fetch next 10 items for a better user experience
        if searchResults.count < (index + 10), !isLoading {
            loadItems(term: searchBar.text!, pageSize: 10, offset: searchResults.count)
        }
    }
}

extension ListItemsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
        
        let item = searchResults[indexPath.row]
        cell.model = ItemCollectionViewCell.Model(item: item)
        if let url = URL(string: item.mediumImage){
            Manager.shared.loadImage(with: url, into: cell.imageView)
        }
        checkIfPrefetchData(index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = searchResults[indexPath.row]
        delegate?.itemWasPressed(item: item)
    }
}

extension ListItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let height = widthPerItem + 50
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
