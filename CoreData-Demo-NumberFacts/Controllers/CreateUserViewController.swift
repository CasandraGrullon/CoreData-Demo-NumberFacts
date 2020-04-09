//
//  CreateUserViewController.swift
//  CoreData-Demo-NumberFacts
//
//  Created by casandra grullon on 4/8/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

protocol CreateUserDelegate: AnyObject {
    func didCreateUser(_ createUserVC: CreateUserViewController, user: User)
}

class CreateUserViewController: UITableViewController {

    @IBOutlet weak var enterNameTextfield: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: CreateUserDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatePicker()
    }
    private func configureDatePicker() {
        datePicker.maximumDate = Date()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let usernameText = enterNameTextfield.text, !usernameText.isEmpty else {
            print("missing user name")
            return
        }
        let date = datePicker.date
        let user = CoreDataManager.shared.createUser(name: usernameText, dob: date)
        
        delegate?.didCreateUser(self, user: user)
        
        dismiss(animated: true)
    }
    

}
