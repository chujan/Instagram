//
//  IGFeedPostGeneralTableViewCell.swift
//  Instagram
//
//  Created by Jennifer Chukwuemeka on 10/11/2022.
//

import UIKit

class IGFeedPostGeneralTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostGeneralTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure() {
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

   

}
