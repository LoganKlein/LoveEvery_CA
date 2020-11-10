//
//  MessagesViewController.swift
//  LoveEvery_CA
//
//  Created by Logan Klein on 11/10/20.
//

import UIKit

class MessagesViewController: UIViewController {
    
    @IBOutlet var mainTV: UITableView!
    @IBOutlet var filterTF: UITextField!
    
    var displayMessages: [Message] = []
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Messages"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkFilter()
    }
    
    // Helper Methods
    
    func collectAllMessages() {
        WebServiceManager.shared().getMessages { (messages) in
            self.displayMessages = messages ?? []
            self.mainTV.reloadData()
        }
    }
    
    func collectFilteredMessages(_ filter: String) {
        WebServiceManager.shared().getMessages(forUser: filter) { (messages) in
            if messages?.count == 0 || messages == nil {
                UIAlertController.showAlert("Error", message: "Unable to collect messages. Try again later", in: self)
                self.filterTF.text = ""
            }
            
            else {
                self.displayMessages = messages ?? []
                self.mainTV.reloadData()
            }
        }
    }
    
    func checkFilter() {
        guard let filter = filterTF.text, filter.isEmpty == false else {
            collectAllMessages()
            return
        }
        
        collectFilteredMessages(filter)
    }
}

// MARK: - UITableViewDataSource Methods

extension MessagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = displayMessages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCellID", for: indexPath)
        cell.textLabel?.text = message.message
        cell.detailTextLabel?.text = message.subject
        return cell
    }
}

extension MessagesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkFilter()
        return false
    }
}
