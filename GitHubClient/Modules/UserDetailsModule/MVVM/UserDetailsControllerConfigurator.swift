//
//  SearchListControllerWireframe.swift
//  GitHubClient
//
//  Created by Roman Bigun on 15.02.2021.
//  
//
import UIKit

class UserDetailsControllerConfigurator {
    lazy var moduleView = UserDetailsControllerView.instantiate()
        // MARK: - Initialization
        init() {}
}

// VIPER Module Constants
struct UserDetailsControllerConstants {
        // Uncomment to utilize a navigation controller from storyboard
        //static let navigationControllerIdentifier = "SearchListControllerNavigationController"
        static let storyboardIdentifier = "UserDetailsControllerView"
        static let viewIdentifier = "UserDetailsControllerView"
}
