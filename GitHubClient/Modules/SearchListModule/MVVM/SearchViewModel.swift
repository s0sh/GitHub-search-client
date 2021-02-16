//
//  ViewMode.swift
//  GitHubClient
//
//  Created by Roman Bigun on 15.02.2021.
//

import Foundation
class SearchViewModel : NSObject {
    var service: APIService!
    var searchDataListener : ([UserInfo]) -> () = {_ in }
    
    override init() {
        super.init()
        service = APIService()
    }
    
    func searching(for searchQueue: String) {
        service.search(with: searchQueue) { (result) in
            if let res = result {
                self.service.fetchUsers(using: res.items, completion: { (users) in
                    self.searchDataListener(Array(users))
                })
           }
        }
    }
}
