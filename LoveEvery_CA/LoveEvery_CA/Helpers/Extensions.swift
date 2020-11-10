//
//  Extensions.swift
//  LoveEvery_CA
//
//  Created by Logan Klein on 11/10/20.
//

import UIKit

extension UITextView {
    func addDoneButton() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.dismiss))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
        
    }

    @objc func dismiss(){
        self.resignFirstResponder()
    }
}

extension UIAlertController {
    class func showAlert(_ title: String, message: String, in VC: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        VC.present(alertController, animated: true, completion: nil)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
}
