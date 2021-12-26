//
//  LoginViewModel.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 08/10/21.
//

import Foundation

//https://file-examples-com.github.io/uploads/2017/10/file_example_PNG_500kB.png

protocol LoginViewDataBinding {
    var userName: String { get set }
    var password: String { get set }
    var role: String? { get set }
}

protocol LoginViewActionBinding {
    func login()
}

protocol LoginViewVaildationBinding {
    var emailValidationAction: ((Bool) -> Void)? { get set }
    var passwordValidationAction: ((Bool) -> Void)? { get set }
    var roleValidationAction: ((Bool) -> Void)? { get set }
}

class LoginViewModel: LoginViewDataBinding, LoginViewVaildationBinding, ObservableObject {
 
    weak var coordinator: (LoginCoordinatorProtocol & AnyObject)?
    
    private let session: SessionProtocol?
    private let loginService: LoginServiceProtocol?
    
    var userName: String {
        didSet {
            print("updated name == \(userName)")
            emailValidationAction?(validateEmail(text: userName))
        }
    }
    var password: String {
        didSet {
            emailValidationAction?(validateEmail(text: password))
        }
    }
    var role: String? {
        didSet {
            
        }
    }
    
    var emailValidationAction: ((Bool) -> Void)?
    var passwordValidationAction: ((Bool) -> Void)?
    var roleValidationAction: ((Bool) -> Void)?
    
    init(session: SessionProtocol = Session.shared,
         loginService: LoginServiceProtocol = LoginService()) {
        self.loginService = loginService
        self.session = session
        self.userName = ""
        self.password = ""
    }
}

extension LoginViewModel: LoginViewActionBinding {
    func login() {
        self.loginService?.login(request: LoginRequest(userName: userName,
                                                       password: password,
                                                       userRole: "User"),
                                 completion: { [weak self] result in
                                    switch result {
                                        case .success(let data):
                                            print(data.accessToken)
                                            self?.session?.store(loginDetail: data)
                                            self?.coordinator?.next()
                                            break
                                        case .failure(let error):
                                            print(error)
                                            break
                                    }
                                 })
    }
}

extension LoginViewModel: LoginFieldValidator {}
