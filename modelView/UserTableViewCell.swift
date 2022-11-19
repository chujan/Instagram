//
//  UserTableViewCell.swift
//  Instagram
//
//  Created by Jennifer Chukwuemeka on 12/11/2022.
//

import UIKit

protocol UserTableViewCellDelegate: AnyObject {
    func didTapfollowButton(model: UserRelationship)
}

enum FollowState {
    case following
    case not_following
}

struct UserRelationship {
    let username: String
    let name: String
    let type: FollowState
}


class UserTableViewCell: UITableViewCell {
    static let identifier = "UserTableViewCell"
    private var model: UserRelationship?
    
    weak var delegate: UserTableViewCellDelegate?
    public func configure(with model: UserRelationship) {
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        switch model.type {
        case.following:
            followButton.setTitle("unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case.not_following:
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .systemBlue
            followButton.layer.borderWidth = 0
            followButton.layer.borderColor = UIColor.label.cgColor
        }
    }

    
    private let ProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "jenny"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
        
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "@jenny"
        label.textColor = .secondaryLabel
       
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
        
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
        
    }()
   



    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView .clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(ProfileImageView)
        contentView.addSubview(followButton)
        selectionStyle = .none
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapfollowButton(model: model)
    }
    
    public func configure(with model: String) {
       
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ProfileImageView.image = nil
        usernameLabel.text = nil
        nameLabel.text = nil
        followButton.layer.borderWidth = 0
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError()
        
       
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        ProfileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        ProfileImageView.layer .cornerRadius = ProfileImageView.height/2.0
        
        let buttonwidth = contentView.width > 500 ? 220.0 : contentView.width/3
        followButton.frame = CGRect(x: contentView.width-5-buttonwidth, y: (contentView.height-40)/2, width: buttonwidth, height: 40)
        let labelHeight = contentView.height/2
        nameLabel.frame = CGRect(x: ProfileImageView.right+5, y: 0, width: contentView.width-5-ProfileImageView.width-buttonwidth, height: labelHeight)
        usernameLabel.frame = CGRect(x: ProfileImageView.right+5, y: nameLabel.bottom, width: contentView.width-8-ProfileImageView.width-buttonwidth, height: labelHeight)
    }
    

}
