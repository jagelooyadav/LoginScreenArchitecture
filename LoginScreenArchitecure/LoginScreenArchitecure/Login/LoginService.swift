//
//  LoginService.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 08/10/21.
//

import Foundation

protocol LoginServiceProtocol {
    func login(request: LoginRequest, completion: ((Result<LoginData, Error>) -> Void)?)
}

struct LoginService: LoginServiceProtocol {
    private let apiClient: APIClientProtocol
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func login(request: LoginRequest, completion: ((Result<LoginData, Error>) -> Void)?) {
        typealias LoginResult = Result<LoginData, Error>
        self.apiClient.call(request: request) { (result: LoginResult) in
            if case let .success(data) = result {
                print(data)
            }
        }
    }
}
