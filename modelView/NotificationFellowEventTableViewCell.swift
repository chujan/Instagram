//
//  NotificationFellowEventTableViewCell.swift
//  Instagram
//
//  Created by Jennifer Chukwuemeka on 15/11/2022.
//

import UIKit
import SDWebImage
protocol NotificationFellowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserNotification)
}

class NotificationFellowEventTableViewCell: UITableViewCell {
static let identifier = "NotificationFellowEventTableViewCell"
    
    weak var delegate: NotificationFellowEventTableViewCellDelegate?
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text =  "jenny started following you"
        label.numberOfLines = 0
        return label
    }()
    
    private let fellowButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(fellowButton)
        selectionStyle = .none
        fellowButton.addTarget(self, action: #selector(didTapFellowButton), for: .touchUpInside)
        configureForFellow()
    }
    
    @objc private func didTapFellowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)

    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case.like(_):
           break
          
        case.fellow(let state):
            switch state {
            case .following:
                configureForFellow()
               
            case .not_following:
                fellowButton.setTitle("follow", for: .normal)
                fellowButton.setTitleColor(.label, for: .normal)
                fellowButton.layer.borderWidth = 0
                fellowButton.backgroundColor = .link
                
            }
            
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
        
       
    }
    private func configureForFellow() {
        fellowButton.setTitle("unfollow", for: .normal)
        fellowButton.setTitleColor(.label, for: .normal)
        fellowButton.layer.borderWidth = 1
        fellowButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fellowButton.setTitle(nil, for: .normal)
        fellowButton.backgroundColor = nil
        fellowButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        let size: CGFloat = 100
        let buttonHeight: CGFloat = 40
        fellowButton.frame = CGRect(x: contentView.width-5-size, y: (contentView.height-buttonHeight)/2, width: size, height: buttonHeight)
        
        label.frame = CGRect(x: profileImageView.right+5, y: 0, width: contentView.width-size-profileImageView.width-16, height: contentView.height)
    }
    

}
