//
//  LoginViewModel.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 08/10/21.
//

import Foundation

protocol LoginViewModelProtocol: class {
    func login()
}

class LoginViewModel: LoginViewModelProtocol {
    var userName: String? {
        didSet {
            print("user name \(userName ?? "")")
        }
    }
    var password: String? {
        didSet {
            print("password changed")
            print("user name \(password ?? "")")
        }
    }
    
    weak var coordinator: LoginCoordinatorProtocol?
    
    private let session: SessionProtocol?
    private let loginService: LoginServiceProtocol?
    
    init(session: SessionProtocol = Session.shared,
         loginService: LoginServiceProtocol = LoginService()) {
        self.loginService = loginService
        self.session = session
    }
    
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

protocol SessionProtocol {
    func store(loginDetail: LoginData?)
}

class Session: SessionProtocol {
    static let shared = Session()
    private var accessToken: String?
    
    func store(loginDetail: LoginData?) {
        guard let data = loginDetail else { return }
        let lock = NSLock()
        lock.lock()
        accessToken = data.accessToken
        lock.unlock()
    }
}
