//
//  CreatePostController.swift
//  CoreData-Demo-NumberFacts
//
//  Created by casandra grullon on 4/8/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

protocol CreatePostDelegate: AnyObject {
    func didCreatePost(_ createPostVC: CreatePostController, post: Post)
}

class CreatePostController: UITableViewController {

    @IBOutlet weak var postTitleTextfield: UITextField!
    @IBOutlet weak var numberFactTextfield: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var users = [User]()
    private var selectedUser: User?
    weak var delegate: CreatePostDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
        fetchUsers()
    }
    
    private func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let titleText = postTitleTextfield.text, !titleText.isEmpty,
            let numberFactText = numberFactTextfield.text, !numberFactText.isEmpty,
            let numberFact = Double(numberFactText) else {
                print("missing fields")
                return
        }
        guard let user = selectedUser else { print("no user selected"); return }
        
        let newPost = CoreDataManager.shared.createPost(for: user, number: numberFact, title: titleText)
        
        delegate?.didCreatePost(self, post: newPost)
        
        dismiss(animated: true)
    }
    
    private func fetchUsers() {
        users = CoreDataManager.shared.fetchUsers()
    }


}
extension CreatePostController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return users[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedUser = users[row]
    }
}
extension CreatePostController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    
    
}
