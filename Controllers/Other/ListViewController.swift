//
//  ListViewController.swift
//  Instagram
//
//  Created by Jennifer Chukwuemeka on 12/11/2022.
//

import UIKit

class ListViewController: UIViewController {
    
    private var data = [UserRelationship]()
    private let tableview: UITableView = {
        let tableVieew = UITableView()
        tableVieew.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        return tableVieew
        
    }()
    
    init(data: [UserRelationship]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }

   

}
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        cell.configure(with: data[indexPath.row])
        cell.delegate = self
        return cell
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.row]
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
}

extension ListViewController: UserTableViewCellDelegate {
    func didTapfollowButton(model: UserRelationship) {
        switch model.type {
        case.following:
            break
        case.not_following:
            break
        }
    }
    
    
}
