//
//  ViewController.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 07/10/21.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet private weak var loginTextfield: TextObservableTextField!
    @IBOutlet private weak var passwordTextfield: TextObservableTextField!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private lazy var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        print("scrollView.frame === \(scrollView.frame)")
        print("scrollView.bounds === \(scrollView.bounds)")
    }
    
    @IBAction func login() {
        self.loginViewModel.login()
    }
    
    func setup() {
        self.loginTextfield.textDidChange = { [weak self] text in
            self?.loginViewModel.userName = text
        }
        self.passwordTextfield.textDidChange = { [weak self] text in
            self?.loginViewModel.password = text
        }
        self.loginTextfield.delegate = self
        self.passwordTextfield.delegate = self
        addKeyboardObserver()
        self.scrollView.delegate = self
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}

extension ViewController {
    func addKeyboardObserver() {
        let notificationCentre = NotificationCenter.default
        notificationCentre.addObserver(self, selector: #selector(self.showKeyBoard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCentre.addObserver(self, selector: #selector(self.hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func showKeyBoard(notification: NSNotification) {
        guard let keyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboard, right: 0.0)
        self.scrollView?.contentInset = contentInset
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.contentInset = .zero
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}
