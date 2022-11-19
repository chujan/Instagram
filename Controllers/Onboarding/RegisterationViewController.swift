//
//  RegisterationViewController.swift
//  Instagram
//
//  Created by Jennifer Chukwuemeka on 09/11/2022.
//

import UIKit
import FirebaseAuth

class RegisterationViewController: UIViewController {
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer .masksToBounds = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field .layer.cornerRadius = 8
        return field
        
        
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer .masksToBounds = true
        field .layer.cornerRadius = 8
        field.backgroundColor = .secondarySystemBackground
       // field.isSecureTextEntry = true
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
        
    }()
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer .masksToBounds = true
        field .layer.cornerRadius = 8
        field.backgroundColor = .secondarySystemBackground
       // field.isSecureTextEntry = true
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
        
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(usernameField)
        view.addSubview(registerButton)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.backgroundColor = .systemBackground

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usernameField.delegate = self
        emailField.delegate = self
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+100, width: view.width-40, height: 52)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom+10, width: view.width-40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom+10, width: view.width-40, height: 52)
    }
    
    @objc private func didTapRegister() {
        emailField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty,password.count >= 8,
                let username = usernameField.text, !username.isEmpty else {
            return
            
        }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
            if registered {
                
            }
            else {
                
            }
        }
        
    }
   
   

}

extension RegisterationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
            
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else {
            didTapRegister()
            
        }
        return true
    }
}

