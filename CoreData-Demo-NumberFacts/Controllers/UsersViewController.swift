//
//  UsersViewController.swift
//  CoreData-Demo-NumberFacts
//
//  Created by casandra grullon on 4/8/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    //get a reference to the CreateUserVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createUserSegue"{
            guard let createUserVC = segue.destination as? CreateUserViewController else {
                fatalError("could not segue to create user vc")
            }
            createUserVC.delegate = self
        }
    }

    
}
extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.dob?.description
        return cell
    }
}
extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
extension UsersViewController: CreateUserDelegate {
    func didCreateUser(_ createUserVC: CreateUserViewController, user: User) {
        users.append(user)
    }
    
    
}
