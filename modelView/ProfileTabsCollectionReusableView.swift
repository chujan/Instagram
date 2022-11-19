//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by Jennifer Chukwuemeka on 11/11/2022.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButtonTab()
    func didTapTaggedButton()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    
    struct Constants {
        static let padding: CGFloat = 8
    }
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor  = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2.fill"), for: .normal)
        return button
        
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor  = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(taggedButton)
        addSubview(gridButton)
        
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
        
    }
    
    @objc private func didTapGridButton() {
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
        
    }
    
    @objc private func didTapTaggedButton() {
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        delegate?.didTapTaggedButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - (Constants.padding + 2)
        let halfwidth = ((width/2)-size)/2
        gridButton.frame = CGRect(x: halfwidth, y: Constants.padding, width: size, height: size)
        taggedButton.frame = CGRect(x: halfwidth + (width/2), y: Constants.padding, width: size, height: size)
    }
    
    
}
