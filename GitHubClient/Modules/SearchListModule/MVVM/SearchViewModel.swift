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
        service.search(with: searchQueue) { [weak self] (result) in
            guard let strongSelf = self else { return }
            if let res = result {
                strongSelf.service.fetchUsers(using: res.items, completion: { (users) in
                    strongSelf.searchDataListener(Array(users))
                })
           }
        }
    }
    
    deinit {
        print("[SEARCH VM] No memory leaks/retain cicles. All bottlenecks covered properly!")
    }
}
