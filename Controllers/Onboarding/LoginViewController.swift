//
//  LoginViewController.swift
//  Instagram
//
//  Created by Jennifer Chukwuemeka on 09/11/2022.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    private let usernameEmailField: UITextField = {
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
        field.isSecureTextEntry = true
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
        
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
        
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
        return header
        
    }()
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Services", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
        
    }()
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
        
    }()
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create an Account", for: .normal)
        return button
        
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameEmailField.delegate = self
        passwordField.delegate = self
        addSubView()
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacy), for: .touchUpInside)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y:0.0, width: view.width, height: view.height/3)
        
        usernameEmailField.frame = CGRect(x: 25, y: headerView.bottom + 40, width: view.width-50, height: 52)
        passwordField.frame = CGRect(x: 25, y: usernameEmailField.bottom + 10, width: view.width-50, height: 52)
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom + 10, width: view.width-50, height: 52)
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom + 10, width: view.width-50, height: 52)
        termsButton.frame = CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom-100, width: view.width-20, height: 50)
        privacyButton.frame = CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom-50, width: view.width-20, height: 50)
        configureHeaderView()
    }
    
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: headerView.width, height: headerView.height - view.safeAreaInsets.top)

    }
    
  
   
   
    
    func addSubView() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
        view.addSubview(createAccountButton)
        
    }
    
    @objc  private func didTapLogin() {
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            email = usernameEmail
            
        }
        else {
            username = usernameEmail
        }
       
        AuthManager.shared.loginUser(username: username, email: email, password: password) {  success in
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true, completion: nil)
                    
                }
                else {
                    let alert = UIAlertController(title: "Log in Error", message: "We were unable to log you in ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                }
            }
            
        }
    }
    @objc private func didTapTerms() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc private func didTapPrivacy() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875?helpref=page_content") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
  
    @objc private func didTapCreateAccount() {
        let vc = RegisterationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }

    

}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField{
            didTapLogin()
        }
        return true
    }
}
