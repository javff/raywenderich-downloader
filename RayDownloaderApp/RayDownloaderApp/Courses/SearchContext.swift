//
//  SearchContext.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 20-11-21.
//

import Foundation
import UIKit

protocol Searchable: Equatable {
    func matching(with text: String) -> Bool
}

class SearchContext<T>: NSObject, UISearchBarDelegate, UISearchResultsUpdating {
    
    private weak var viewController: UIViewController?
    private let searchController = UISearchController(searchResultsController: nil)
    private let placeholder: String?
    private let debounceInterval: TimeInterval
    private var timer: Timer?
    
    var isFilterApplied: Bool = false
    var items:[T] = []
    fileprivate var filterItems:[T] = []
    
    var currentItems:[T] {
        isFilterApplied ? filterItems : items
    }
    
    var updateChanges: (() -> Void)?
    
    init(placeholder: String?, viewController: UIViewController, debounceInterval: TimeInterval = .zero) {
        self.placeholder = placeholder
        self.viewController = viewController
        self.debounceInterval = debounceInterval
        super.init()
    }
    
    func configure() {
        viewController?.navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = placeholder
        viewController?.navigationItem.searchController = searchController
        viewController?.definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: debounceInterval, repeats: false) { _ in
            guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
                self.isFilterApplied = false
                self.updateChanges?()
                return
            }
            self.isFilterApplied = true
            self.filterItems = []
            self.updateChanges?()
            self.applyMatching(with: searchText)
            self.timer?.invalidate()
        }
    }
        
    func applyMatching(with text: String) {
//        Only override //
    }
    
}


class LocalSearchContext: SearchContext<Searchable> {
    
    override func applyMatching(with text: String) {
        filterItems = items.filter { $0.matching(with: text) }
        updateChanges?()
    }
}

protocol RemoteSearchContextDelegate: AnyObject {
    func searchItems(with text: String)
}

class RemoteSearchContext<T> : SearchContext<T> {
    
    weak var delegate: RemoteSearchContextDelegate?
    var updater: ((Result<[T],Error>) -> Void)?
    
    override init(placeholder: String?, viewController: UIViewController, debounceInterval: TimeInterval = .zero) {
        super.init(placeholder: placeholder, viewController: viewController, debounceInterval: debounceInterval)
        
        updater = {[weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                self.filterItems = data
                self.updateChanges?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func applyMatching(with text: String) {
        delegate?.searchItems(with: text)
    }
}
