//
//  PostViewController.swift
//  Instagram
//
//  Created by Jennifer Chukwuemeka on 11/11/2022.
//

import UIKit

enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost)
    case actions(provider: String)
    case comments(comments: [PostComment])
}

struct PostRenderViewModel  {
 let  renderType: PostRenderType
}

class PostViewController: UIViewController {
    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier:IGFeedPostGeneralTableViewCell.identifier)
        return tableView
        
    }()
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    private func configureModels() {
        guard  let userPostModel = self.model else {
            return
        }
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(PostComment(identifier: "123_\(x)", username: "@jenny", text: "Great post", createdDate: Date(), like: []))
            
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)

        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    

    

}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case.actions(_): return 1
        case.comments(let comments): return comments.count > 4 ? 4 : comments.count
        case.header(_): return 1
        case.primaryContent(_): return 1
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model  = renderModels[indexPath.section]
        switch model.renderType {
        case.actions(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier, for: indexPath) as! IGFeedPostActionTableViewCell
            return cell
        case.comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
            return cell
        case.header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
            return cell
        case.primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model  = renderModels[indexPath.section]
        switch model.renderType {
        case.actions(_):
            return 60
            
        case.comments(_):
            
            return 50
        case.header(_):
            
             return 70
        case.primaryContent(_):
           
            return tableView.width
            
        }
    }
    
    
}
