//
//  AddMessageViewController.swift
//  LoveEvery_CA
//
//  Created by Logan Klein on 11/10/20.
//

import UIKit

class AddMessageViewController: UIViewController {
    
    @IBOutlet var usernameTF: UITextField!
    @IBOutlet var subjectTF: UITextField!
    @IBOutlet var messageTV: UITextView!
    @IBOutlet var postBtn: UIButton!
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add New Message"
        
        // Apply some styling
        messageTV.layer.cornerRadius = 5
        postBtn.layer.cornerRadius = 5
        messageTV.addDoneButton()
    }
    
    // MARK: - IBAction Methods
    
    @IBAction func sendMessage() {
        guard let user = usernameTF.text else {
            UIAlertController.showAlert("Error", message: "You must enter a name to submit a message.", in: self)
            return
        }
        
        guard let subject = subjectTF.text else {
            UIAlertController.showAlert("Error", message: "You must enter a subject to submit a message.", in: self)
            return
        }
        
        guard let message = messageTV.text else {
            UIAlertController.showAlert("Error", message: "The message must contain text.", in: self)
            return
        }
        
        WebServiceManager.shared().postMessage(user: user, subject: subject, message: message) { (success) in
            if success {
                UIAlertController.showAlert("Success", message: "Message Posted!", in: self)
                self.usernameTF.text = nil
                self.subjectTF.text = nil
                self.messageTV.text = nil
            }
            
            else {
                UIAlertController.showAlert("Error", message: "Unable to Post Message.", in: self)
            }
        }
    }
}

// MARK: - UITextFieldDelegate Methods

extension AddMessageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTF { subjectTF.becomeFirstResponder() }
        else if textField == subjectTF { messageTV.becomeFirstResponder() }
        return false
    }
}

// MARK: - UITextViewDelegate Methods

extension AddMessageViewController: UITextViewDelegate {
    
}
