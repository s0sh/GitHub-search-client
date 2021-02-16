//
//  Coordinator.swift
//  GitHubClient
//
//  Created by Roman Bigun on 15.02.2021.
//
import UIKit

enum DisplayStrategy {
    case githubUsersList
    case githubUserDetails(UserInfo)
}

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        // this splits by the dot and uses everything after, giving "MyViewController" or whatever controller instantiated
        let className = fullName.components(separatedBy: ".")[1]
        // load our storyboard. Storiboard name should be the sane as class name in my case
        let storyboard = UIStoryboard(name: className, bundle: Bundle.main)
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start(stratrgy: DisplayStrategy)
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func userDetails(data: UserInfo) {
        let wf = UserDetailsControllerConfigurator()
        let vc = wf.moduleView
        vc.coordinator = self
        vc.userInfo = data
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func coordinatorFabric(strategy: DisplayStrategy, user: UserInfo? = nil) {
        switch strategy {
            case .githubUsersList:
                let wf = SearchListControllerConfigurator()
                let vc = wf.moduleView
                vc.coordinator = self
                navigationController.pushViewController(vc, animated: true)
            case .githubUserDetails(user: let user):
            userDetails(data: user)
        }
    }
    
    func start(stratrgy: DisplayStrategy) {
        coordinatorFabric(strategy: stratrgy)
    }
}
