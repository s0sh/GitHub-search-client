//
//  SearchListControllerWireframe.swift
//  GitHubClient
//
//  Created by Roman Bigun on 15.02.2021.
//  
//
import UIKit

class SearchListControllerConfigurator {
    lazy var moduleView = SearchListControllerView.instantiate()
        // MARK: - Initialization
        init() {}
}

// VIPER Module Constants
struct SearchListControllerConstants {
        // Uncomment to utilize a navigation controller from storyboard
        //static let navigationControllerIdentifier = "SearchListControllerNavigationController"
        static let storyboardIdentifier = "SearchListControllerView"
        static let viewIdentifier = "SearchListControllerView"
}

// VIPER Interface for manipulating the navigation of the view
protocol SearchListControllerNavigationInterface: class {

}
