//
//  ViewController.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 07/10/21.
//

import UIKit
import Foundation
import Combine

class LoginViewController: UIViewController, ObservableObject {
    
    @IBOutlet private weak var loginTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    private var cancellable = Set<AnyCancellable>()
    @IBOutlet private weak var scrollView: UIScrollView!
    private lazy var loginViewModel: LoginFieldValidator
    & LoginViewActionBinding
    & LoginViewDataBinding
    & LoginViewVaildationBinding
    & AnyObject = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        loginButton.actionPublisher.sink { [weak self] _ in
            self?.login()
        }.store(in: &cancellable)
    }
    
    @IBAction func login() {
        self.loginViewModel.login()
    }
    
    func setup() {
        loginTextfield.textChange
            .assign(to: \LoginViewModel.userName, on: loginViewModel as! LoginViewModel)
            .store(in: &cancellable)
        passwordTextfield.textChange
            .assign(to: \LoginViewModel.password, on: loginViewModel as! LoginViewModel)
            .store(in: &cancellable)
        
        loginViewModel.emailValidationAction = { _ in
            print("email is valid")
        }
        loginViewModel.passwordValidationAction = { _ in
            print("password is valid")
        }
        loginTextfield.delegate = self
        passwordTextfield.delegate = self
        addKeyboardObserver()
        scrollView.delegate = self
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}

extension LoginViewController {
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

extension LoginViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}
