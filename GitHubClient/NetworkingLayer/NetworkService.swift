//
//  NetworkService.swift
//  GHS
//
//  Created by Roman Bigun on 15.02.2021.
//
import Foundation
import PromiseKit

private struct URLConstructor {
    func constructSearchUrl(with param: String) -> URL? {
        return URL(string: "https://api.github.com/search/users?q=\(param)")
    }
    func constructUserUrl(with param: String) -> URL? {
        return URL(string: "https://api.github.com/users/\(param)")
    }
    func constructReposUrl(with param: String) -> URL? {
        return URL(string: "https://api.github.com/users/\(param)/repos")
    }
}

final class APIService {
    private let jsonDecoder = JSONDecoder()
    private let headers = ["Accept": "application/vnd.github.v3+json",
                           "Authorization": "Bearer YOURS-JWT-TOKEN"]
    
    func search(with query: String, completion: @escaping (UserListElement?) -> Void ) {
        guard let searchQuery = URLConstructor().constructSearchUrl(with: query) else { return }
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
    
    private func getUser(by name: String, completion: @escaping (UserInfo?) -> () )  {
        guard let query = URLConstructor().constructUserUrl(with: name) else { return }
        firstly {
            Alamofire
                .request(query, method: .get, parameters: nil,headers: headers)
                .responseDecodable(UserInfo.self)
        }.done { user in
            completion(user)
        }.catch { error in
            print(error)
            completion(nil)
        }
    }
    
    func getRepos(for username: String, completion: @escaping ([Repo]?) -> () )  {
        guard let query = URLConstructor().constructReposUrl(with: username) else { return }
        firstly {
            Alamofire
                .request(query, method: .get, parameters: nil,headers: headers)
                .responseDecodable([Repo].self)
        }.done { repos in
            completion(repos)
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
            self.getUser(by: name, completion: { user in
                if user != nil {
                    result.append(user!)
                }
                myGroup.leave()
            })
        }
        myGroup.notify(queue: .main) {
            print("Finished all Users requests.")
            completion(result)
        }
    }
}

