//
//  GitHubClientTests.swift
//  GitHubClientTests
//
//  Created by Roman Runner on 23.02.2021.
//

import XCTest
@testable import GitHubClient

class GitHubClientTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchViewModel() {
        let searchViewModel = SearchViewModel()
        searchViewModel.service.search(with: "a") { [weak searchViewModel] (result) in
            guard let strongSelf = searchViewModel else { return }
            if let res = result {
                strongSelf.service.fetchUsers(using: res.items, completion: { (data) in
                    XCTAssertEqual(data.count, 0, "items count must be > than 0")
                })
           }
        }
    }
    
    func testDetailsViewModelRepos() {
        let detailsViewModel = SearchViewModel()
        detailsViewModel.service.getData(target: .repos("s0sh"/*my login*/)) { (repos: Repos?) in
            if let repos = repos {
                XCTAssertEqual(repos.count, 0, "Repos count must be > than 0")
            }
            else {
                XCTAssertEqual(nil, "Repo for any login must exists")
            }
        }
    }
}
