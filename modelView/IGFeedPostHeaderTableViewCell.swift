//
//  IGFeedPostHeaderTableViewCell.swift
//  Instagram
//
//  Created by Jennifer Chukwuemeka on 10/11/2022.
//

import UIKit
import SDWebImage
protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostHeaderTableViewCell"
    
    weak var delegate: IGFeedPostHeaderTableViewCellDelegate?
    private let ProfilePhotoImageView: UIImageView = {
      let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.layer.masksToBounds = true
        ImageView.contentMode = .scaleAspectFill
        return ImageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(ProfilePhotoImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapButton() {
        delegate?.didTapMoreButton()
        
    }
    
    public func configure(with model: User) {
        usernameLabel.text = model.username
        ProfilePhotoImageView.image = UIImage(systemName: "person.circle")
       // ProfilePhotoImageView.sd_setImage(with: model.profilePhoto, completed: nil)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height-4
        ProfilePhotoImageView.frame = CGRect(x: 2, y: 2, width: size, height: size)
        ProfilePhotoImageView.layer.cornerRadius = size/2
        moreButton.frame = CGRect(x: contentView.width-size, y: 2, width: size, height: size)
        usernameLabel.frame = CGRect(x: ProfilePhotoImageView.right+10, y: 2, width: contentView.width-(size+2)-15, height: contentView.height-4)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = nil
        ProfilePhotoImageView.image = nil
    }

   

}
