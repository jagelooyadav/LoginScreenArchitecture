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
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func login(request: LoginRequest, completion: ((Result<LoginData, Error>) -> Void)?) {
        let json = try? JSONEncoder().encode(request)
        print("json request ==== \(String.init(data: json!, encoding: .utf8))")
        apiClient.call(requestData: json) { response in
            if response != nil {
                completion?(.success(LoginData.init(accessToken: "12345677", user: User.init(firstName: "First name", lastName: "last name"))))
            }
        }
    }
}

protocol APIClientProtocol {
    func call(requestData: Data?, completion: ((Data?) -> Void)?)
}

class APIClient: APIClientProtocol {
    static let shared = APIClient()
    
    func call(requestData: Data?, completion: ((Data?) -> Void)?) {
        let data = "{\"success\": true}".data(using: .utf8)
        completion?(data)
    }
}
