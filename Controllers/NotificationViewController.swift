//
//  NotificationViewController.swift
//  Instagram
//
//  Created by Jennifer Chukwuemeka on 09/11/2022.
//

import UIKit
enum UserNotificationType {
    case like(post: UserPost)
    case fellow(state: FollowState)
    
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFellowEventTableViewCell.self, forCellReuseIdentifier: NotificationFellowEventTableViewCell.identifier)
        return tableView
    }()
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var noNotificationView = NoNotificationView()
    private var models = [UserNotification]()
        
        
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        navigationItem.title = "Notification"
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        view.addSubview(spinner)
        //spinner.startAnimating()
        view.addSubview(tableView)
       
       // view.addSubview(noNotificationView)
       

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
        
    }
    
    private func fetchNotifications() {
        for x in 0...100 {
        let user = User(username: "jenny", name: (first: "", last: ""), birthDate: Date(), gender: .female, profilePhoto: URL(string: "https://www.google.com/")!, count: UserCount(following: 1, followers: 1, posts: 1), joinDate: Date())
       
            let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com/")!, postURL: URL(string: "https://www.goggle.com/")!, caption: nil, likeCount: [], comments: [], createdDate: Date(), taggedUser: [], owner: user)
            
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .fellow(state: .not_following), text: "hello word", user: user)
            models.append(model)
        }
    }
    private func addNoNotificationView() {
        tableView.isHidden = true
        view.addSubview(tableView)
        noNotificationView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        noNotificationView.center = view.center
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model .type {
        case.like(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case.fellow:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFellowEventTableViewCell.identifier, for: indexPath) as! NotificationFellowEventTableViewCell
            
           // cell.configure(with: model)
            cell.delegate = self
            return cell
            
            
        }
      
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
  
}
extension NotificationViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        switch model.type {
        case.like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case.fellow(_):
            fatalError("Dev Issue: Should never get called")
        }
       
    }
}

extension NotificationViewController: NotificationFellowEventTableViewCellDelegate {
    func didTapFollowUnfollowButton(model: UserNotification) {
        print("tapped po")
    }
    
    
}
