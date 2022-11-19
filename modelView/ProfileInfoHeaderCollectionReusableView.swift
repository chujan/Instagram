//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Jennifer Chukwuemeka on 11/11/2022.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
    
}

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let EditProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Jeny"
        label.numberOfLines = 1
        return label
    }()
    
    private let BioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "This is the first account"
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       addButtonActions()
        clipsToBounds = true
        addSubview()
        backgroundColor = .systemBackground
        
    }
    private func addButtonActions() {
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(didTappostButton), for: .touchUpInside)
        EditProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
    }
   
    
    private func addSubview() {
        addSubview(profilePhotoImageView)
        addSubview(BioLabel)
        addSubview(nameLabel)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(postButton)
        addSubview(EditProfileButton)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(x: 5, y: 5, width: profilePhotoSize, height: profilePhotoSize).integral
        profilePhotoImageView.layer.cornerRadius =  profilePhotoSize/2
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width-10-profilePhotoSize)/3
        postButton.frame = CGRect(x: profilePhotoImageView.right, y: 5, width: countButtonWidth, height: buttonHeight)
        followersButton.frame = CGRect(x: postButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        followingButton.frame = CGRect(x: followersButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        EditProfileButton.frame = CGRect(x: profilePhotoImageView.right, y: 5 + buttonHeight, width: countButtonWidth*3, height: buttonHeight).integral
        nameLabel.frame = CGRect(x: 5, y: 5 + profilePhotoImageView.bottom, width: width-10, height: 50).integral
        let bioLabelSize = BioLabel.sizeThatFits(frame.size)
        BioLabel.frame = CGRect(x: 5, y: 5 + nameLabel.bottom, width: width-10, height: bioLabelSize.height).integral
        
       
    }
    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
        
    }
    @objc private func didTappostButton () {
        delegate?.profileHeaderDidTapPostButton(self)
        
    }
    @objc private func didTapEditProfileButton () {
        delegate?.profileHeaderDidTapProfileButton(self)
        
    }
    @objc private func didTapFollowersButton () {
        delegate?.profileHeaderDidTapFollowersButton(self)
        
    }
    
   
        
}
