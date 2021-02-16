//
//  UserInfoView.swift
//  GitHubClient
//
//  Created by Roman Bigun on 15.02.2021.
//

import UIKit
import Kingfisher
final class UserInfoView: UIView {
    var data: UserInfo! {
        didSet {
            setupView()
        }
    }
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userEmailLabel: UILabel!
    @IBOutlet var userLocationLabel: UILabel!
    @IBOutlet var joinDateLabel: UILabel!
    @IBOutlet var followersLabel: UILabel!
    @IBOutlet var followingLabel: UILabel!
    @IBOutlet var bioTextView: UITextView!
    
    private func setupView() {
        if let url = URL(string: data.avatarURL) {
            _ = avatarImageView.kf.setImage(with: url)
        } else {
            avatarImageView.image = UIImage(named: "ghcat")
        }
        userNameLabel.text = "Name: \(data.name ?? "--")"
        userEmailLabel.text = "Email: \(data.email ?? "--")"
        userLocationLabel.text = "Location: \(data.location ?? "--")"
        joinDateLabel.text = "Joined date: \(String(data.createdAt.prefix(10)))"
        followersLabel.text = "Followers: \(data.followers)"
        followingLabel.text = "Following: \(data.following)"
        bioTextView.text = "\(data.bio ?? "-=No information provided=-")"
        bioTextView.isEditable = false
    }
}
