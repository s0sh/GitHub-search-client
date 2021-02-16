//
//  SearchView.swift
//  GHS
//
//  Created by Roman Bigun on 15.02.2021.
//

import UIKit

class SearchView: UIView {
    //MARK: - Superview of this view should use this closure to listen to query string changes and search will automatically update upon each letter entered
    var searchStringUpdated: (String)->() = ( { _ in } )
    private var searchBar: UISearchBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
   private func setupView() {
        searchBar = UISearchBar(frame: frame)
        addSubview(searchBar)
        searchBar.delegate = self
    }
}

extension SearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchStringUpdated(searchText)
    }
}
