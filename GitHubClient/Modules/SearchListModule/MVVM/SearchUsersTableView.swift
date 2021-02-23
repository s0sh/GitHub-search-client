//
//  SearchUsersTableView.swift
//  GitHubClient
//
//  Created by Roman Bigun on 15.02.2021.
//

import UIKit

class SearchListControllerView: GenericTableViewController<UserListItemCell, UserInfo>, Storyboarded {
    var coordinator: MainCoordinator?
    @IBOutlet var searchView: SearchView!
    private var viewModel: SearchViewModel!
    
    override var items: [UserInfo] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel()
        
        searchView.searchStringUpdated = { [weak self] searchQueue in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.searching(for: searchQueue)
        }
        
        self.viewModel.searchDataListener = { [weak self] searchResult in
            guard let strongSelf = self else { return }
            strongSelf.items = searchResult
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.userDetails(data: items[indexPath.row])
    }
    
    deinit {
        print("[SEARCH] No memory leaks/retain cicles. All bottlenecks covered properly!")
    }
}
