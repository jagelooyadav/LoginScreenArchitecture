//
//  LoginService.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 08/10/21.
//

import Foundation

protocol LoginServiceProtocol {
    func login(request: LoginRequest, completion: ((Result<LoginData, LoginError>) -> Void)?)
}

struct LoginService: LoginServiceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func login(request: LoginRequest, completion: ((Result<LoginData, LoginError>) -> Void)?) {
        guard let requestData = try? JSONEncoder().encode(request) else {
            completion?(.failure(LoginError.invalidResponse))
            return
        }
        self.apiClient.call(requestData: requestData) { _, _, _ in
            completion?(.success(LoginData.init(accessToken: "", user: User.init(firstName: "Yadav", lastName: "yadav"))))
        }
    }
}

protocol APIClientProtocol {
    func call(requestData: Data?, completion: ((Data?, URLResponse?, Error?) -> Void)?)
}

class APIClient: APIClientProtocol {
    
    private var task: URLSessionTask?
    private let urlSession = URLSession.shared
    private let networkConfig: NetworkConfigProtocol
    
    init(networkConfig: NetworkConfigProtocol = NetworkConfig()) {
        self.networkConfig = networkConfig
    }
    
    func call(requestData: Data?, completion: ((Data?, URLResponse?, Error?) -> Void)?) {
        completion?(nil, nil, nil)
        guard let url = URL.init(string: self.networkConfig.urlString) else {
            completion?(nil, nil, nil)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = networkConfig.method
        urlRequest.httpBody = requestData
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            completion?(data, response, error)
        }).resume()
    }
}

protocol NetworkConfigProtocol {
    var baseURL: String { get }
    var path: String? { get }
    var method: String { get }
}

extension NetworkConfigProtocol {
    var urlString: String {
        return baseURL + (path ?? "")
    }
}

struct NetworkConfig: NetworkConfigProtocol {
    var baseURL: String = ""
    var path: String?
    var method: String = "POST"
}
