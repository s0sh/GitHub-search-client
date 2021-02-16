//
//  SearchUsersTableView.swift
//  GitHubClient
//
//  Created by Roman Bigun on 15.02.2021.
//

import UIKit

class UserDetailsControllerView: UIViewController, Storyboarded {
    var coordinator: MainCoordinator?
    private var dataSource : GenericTableViewDataSource<RepoCell, Repo>!
    @IBOutlet var userInfoView: UserInfoView!
    @IBOutlet var searchView: SearchView!
    @IBOutlet var tableView: UITableView!
    private var viewModel: UserDetailsViewModel!
    var userInfo: UserInfo!
    
    var items: [Repo]! {
        didSet {
            self.dataSource = GenericTableViewDataSource(cellIdentifier: "RepoCell",
                                                         items: items,
                                                         configureCell: { (cell, evm) in
                cell.item = evm
            })
            
            self.tableView.dataSource = self.dataSource
            self.tableView.delegate = self.dataSource
            self.tableView.reloadData()
            
            self.dataSource.cellPressed = { index in
                if let url = URL(string: self.items[index].htmlURL!) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userInfoView.data = userInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        viewModel = UserDetailsViewModel()
        viewModel.loadRepos(for: userInfo.login)
        searchView.searchStringUpdated = { searchQueue in
            self.viewModel.searching(for: searchQueue)
        }
        self.viewModel.searchDataListener = { searchResult in
            self.items = searchResult
        }
    }
}
