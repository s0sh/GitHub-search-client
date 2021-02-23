//
//  NetworkService.swift
//  GHS
//
//  Created by Roman Bigun on 15.02.2021.
//
import Foundation
import PromiseKit

enum URLTarget {
   case user(String)
   case repos(String)
   case search(String)
}

struct URLConstructor {
    private func constructSearchUrl(with param: String) -> URL? {
        return URL(string: "https://api.github.com/search/users?q=\(param)")
    }
    
    private func constructUserUrl(with param: String) -> URL? {
        return URL(string: "https://api.github.com/users/\(param)")
    }
    
    private func constructReposUrl(with param: String) -> URL? {
        return URL(string: "https://api.github.com/users/\(param)/repos")
    }
    
    func getURL(for target: URLTarget) -> URL? {
        switch target {
        case .repos(let repoName):
            return constructReposUrl(with: repoName)
        case .search(let query):
            return constructSearchUrl(with: query)
        case .user(let userName):
           return constructUserUrl(with: userName)
        }
    }
}

final class APIService {
    
    private let jsonDecoder = JSONDecoder()
    private let headers = ["Accept": "application/vnd.github.v3+json",
                           "Authorization": "Bearer "]
    private let urlConstructor = URLConstructor()
    
    func search(with query: String, completion: @escaping (UserListElement?) -> Void ) {
        guard let searchQuery = urlConstructor.getURL(for: .search(query)) else { return }
        firstly {
            Alamofire
                .request(searchQuery, method: .get, parameters: nil, headers: headers)
                .responseDecodable(UserListElement.self)
        }.done { user in
            completion(user)
        }.catch { error in
            print(error)
            completion(nil)
        }
    }
   
    func getData<T: Decodable>(for name: String, target: URLTarget, completion: @escaping (T?) -> () ) {
        guard let query = urlConstructor.getURL(for: target) else { return }
        firstly {
            Alamofire
                .request(query, method: .get, parameters: nil,headers: headers)
                .responseDecodable(T.self)
        }.done { user in
            completion(user)
        }.catch { error in
            print(error)
            completion(nil)
        }
    }
    
    func fetchUsers(using elements: [Item], completion: @escaping ([UserInfo]) -> Void) {
        let userNames = elements.map { $0.login }
        var result = [UserInfo]()
        let myGroup = DispatchGroup()
        for name in userNames {
            myGroup.enter()
            self.getData(for: name, target: .user(name)) { (user: UserInfo?) in
                if user != nil {
                    result.append(user!)
                }
                myGroup.leave()
            }
        }
        myGroup.notify(queue: .main) {
            print("Finished all Users requests.")
            completion(result)
        }
    }
}

