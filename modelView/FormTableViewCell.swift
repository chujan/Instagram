//
//  FormTableViewCell.swift
//  Instagram
//
//  Created by Jennifer Chukwuemeka on 11/11/2022.
//

import UIKit
protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFromModel)
        
    
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    
    static let identifier = "FormTableViewCell"
    private var model: EditProfileFromModel?
    
    public weak var delegate: FormTableViewCellDelegate?
    
    private let formLabel: UILabel = {
        let  label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
        
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
        
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field .delegate = self
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
     func configure(with model: EditProfileFromModel) {
         self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.width/3, height: contentView.height)
        field.frame = CGRect(x: formLabel.right - 5, y: 0, width: contentView.width-10-formLabel.width, height: contentView.height)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else {
            return true
           
        }
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
    
    
}
