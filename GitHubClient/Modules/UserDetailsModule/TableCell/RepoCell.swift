//
//  UserListItemCell.swift
//  GitHubClient
//
//  Created by Roman Bigun on 15.02.2021.
//

import UIKit

class RepoCell: BaseCell<Repo> {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var forksLabel: UILabel!
    @IBOutlet var starsLabel: UILabel!
    private lazy var textsYAxis = frame.height / 2 - 10
    override var item: Repo! {
        didSet {
            nameLabel.text = item.name
            forksLabel.text = "Forks: \(item.forksCount)"
            starsLabel.text = "Stars: \(item.stargazersCount)"
        }
    }
}
