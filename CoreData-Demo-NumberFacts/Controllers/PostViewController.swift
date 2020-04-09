//
//  ViewController.swift
//  CoreData-Demo-NumberFacts
//
//  Created by casandra grullon on 4/8/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchPosts()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createPostSegue" {
            guard let createPostVC = segue.destination as? CreatePostController else {
                fatalError("could not segue to create post vc")
            }
            createPostVC.delegate = self
        }
    }
    private func fetchPosts() {
        posts = CoreDataManager.shared.fetchPosts()
    }
    


}
extension PostViewController: UITableViewDelegate {
    
}
extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = "\(post.title ?? "")\t\(post.number)"
        cell.detailTextLabel?.text = "by: \(post.user?.name ?? "")"
        return cell
    }
    
    
}
extension PostViewController: CreatePostDelegate {
    func didCreatePost(_ createPostVC: CreatePostController, post: Post) {
        posts.append(post)
    }
    
    
}
