//
//  ViewController.swift
//  Instagram
//
//  Created by Jennifer Chukwuemeka on 09/11/2022.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
   
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier:IGFeedPostGeneralTableViewCell.identifier)
        return tableView
        
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        createMockModels()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
       
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func createMockModels() {
        let user = User(username: "@jenny", name: (first: "", last: ""), birthDate: Date(), gender: .female, profilePhoto: URL(string: "https://www.google.com/")!, count: UserCount(following: 1, followers: 1, posts: 1), joinDate: Date())
       
            let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com/")!, postURL: URL(string: "https://www.goggle.com/")!, caption: nil, likeCount: [], comments: [], createdDate: Date(), taggedUser: [], owner: user)
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(identifier: "\(x)", username: "@jenny", text: "This i the best post i have seen", createdDate: Date(), like: []))
        }
            
        for x in 0..<5 {
            
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)), post: PostRenderViewModel(renderType: .primaryContent(provider: post)), actions: PostRenderViewModel(renderType: .actions(provider: "")), comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
        }
        
    }
    
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
            
            
        }
        
    }


}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        }
        else {
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
            
        }
        let subSection = x % 4
        if subSection == 0 {
            return 1
            
        } else if subSection == 1 {
            return 1
            
        } else if subSection == 2 {
            return 1
            
        } else if subSection == 3 {
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case.header, .actions, .primaryContent: return 0
           
            }
            
        }
        return 0
        
           
        
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        }
        else {
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
            
        }
        
        let subSection = x % 4
        if subSection == 0 {
            let headerModel = model.header
            switch headerModel.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case.comments, .actions, .primaryContent: return UITableViewCell()
            }
          
            
        } else if subSection == 1 {
            let postModel = model.post
            switch postModel.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                cell.configure(with: post)
                return cell
            case.comments, .actions, .header: return  UITableViewCell()
            }
            
           
            
        } else if subSection == 2 {
            let actionModel = model.actions
            switch actionModel.renderType {
            case .actions(let provider):
                
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier, for: indexPath) as! IGFeedPostActionTableViewCell
                cell.delegate = self
                return cell
            case.comments, .primaryContent, .header: return  UITableViewCell()
            }
            
            
        } else if subSection == 3 {
            
            let commentModel = model.comments
            
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            case.primaryContent, .actions, .header: return  UITableViewCell()
            }
            
        }
        return UITableViewCell()
        
            
        }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0 {
            return 70
        }
        else if subSection == 1 {
            return tableView.width
            
        } else if subSection == 2 {
            return 60
            
        } else if subSection == 3 {
            return 50
            
        }
        return 0
       
        }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
    

}
extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate {
    func didTapMoreButton() {
        let actionsheet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler: { [weak self]  _ in
            self?.reportPost()
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionsheet, animated: true)
    }
    func reportPost() {
        
    }
    

}
extension HomeViewController: IGFeedPostActionTableViewCellDelegate {
    func didTapLikeButton() {
        print("like")
    }
    
    func didTapCommentButton() {
        print("comment")
    }
    
    func didTapSendButton() {
        print("send")
    }
    
    
}



