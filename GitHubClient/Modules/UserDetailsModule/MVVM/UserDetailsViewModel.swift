//
//  ViewModel.swift
//  GitHubClient
//
//  Created by Roman Bigun on 15.02.2021.
//

import Foundation
class UserDetailsViewModel : NSObject {
    var service: APIService!
    var searchDataListener : ([Repo]) -> () = {_ in }
    var repoData: Repos!
    
    override init() {
        super.init()
        service = APIService()
    }
    
    func searching(for searchQueue: String) {
        guard repoData != nil else { return }
        if searchQueue.count == 0 {
            searchDataListener(repoData)
        } else {
            let filteredArray = repoData.filter { $0.name!.uppercased().contains(searchQueue.uppercased()) }
            searchDataListener(filteredArray)
        }
    }
    
    func loadRepos(for name: String) {
        service.getData(for: name, target: .repos(name)) { (repos: Repos?) in
            if repos != nil {
                self.repoData = repos
                self.searchDataListener(repos!)
            }
        }
    }
}
