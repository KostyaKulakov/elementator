//
//  IntroViewController.swift
//  Elementator
//
//  Created by Konstantin Kulakov on 01/04/2019.
//  Copyright © 2019 Konstantin Kulakov. All rights reserved.
//

import UIKit

protocol IntroViewProtocol: class {
    func showNotice(_ msg: String)
    func segueToElementor()
}

class IntroViewController: UIViewController {
    var presenter: IntroPresenter?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var jsonUrlTextField: UITextField!
    
    @IBAction func handleJsonButton(_ sender: Any) {
        guard let presenter = self.presenter, let url = jsonUrlTextField.text else { return }
        
        presenter.handleJson(url: url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = IntroPresenter(view: self)
        
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
}

extension IntroViewController: IntroViewProtocol {
    func segueToElementor() {
        performSegue(withIdentifier: "elementorBoard", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "elementorBoard" {
            if let viewController = segue.destination as? ElementorBoardTableView {
                    viewController.data = self.presenter?.dataToView
            }
        }
    }
}
