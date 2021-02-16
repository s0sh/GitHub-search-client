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
        
        searchView.searchStringUpdated = { searchQueue in
            self.viewModel.searching(for: searchQueue)
        }
        
        self.viewModel.searchDataListener = { searchResult in
            self.items = searchResult
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.userDetails(data: items[indexPath.row])
    }
}
