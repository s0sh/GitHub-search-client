//
//  UserListItemCell.swift
//  GitHubClient
//
//  Created by Roman Bigun on 15.02.2021.
//

import UIKit
import Kingfisher

class UserListItemCell: BaseCell<UserInfo> {
    private var avatarImageView: UIImageView!
    private var nameLabel: UILabel!
    private var reposNumberLabel: UILabel!
    private var isSet = false
    private lazy var textsYAxis = frame.height / 2 - 10
    override var item: UserInfo! {
        didSet {
            constractCellIfNeeded()
            if let url = URL(string: item.avatarURL) {
                _ = avatarImageView.kf.setImage(with: url)
            } else {
                avatarImageView.image = UIImage(named: "ghcat")
            }
            nameLabel.text = item.name
            reposNumberLabel.text = "Repo: \(item.publicRepos)"
        }
    }
}

extension UserListItemCell {
    func constractCellIfNeeded() {
        if nameLabel == nil {
            //Magic numbers
            avatarImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 62, height: 62))
            avatarImageView.layer.cornerRadius = 9
            avatarImageView.clipsToBounds = true
            nameLabel = UILabel(frame: CGRect(x: 100, y: textsYAxis , width: 82, height: 21))
            reposNumberLabel = UILabel(frame: CGRect(x: 162, y: textsYAxis, width: frame.width - 185, height: 21))
            
            addSubview(avatarImageView)
            addSubview(nameLabel)
            addSubview(reposNumberLabel)
            
            nameLabel.textAlignment = .center
            reposNumberLabel.textAlignment = .right
        }
    }
}
