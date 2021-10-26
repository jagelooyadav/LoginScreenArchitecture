//
//  APIClient.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 26/10/21.
//

import Foundation

protocol APIClientProtocol {
    func call<R: Encodable, T: Decodable>(request: R, completion: ((Result<T, Error>) -> Void)?)
}

class APIClient: APIClientProtocol {
    private let networkConfig: NetworkConfigProtocol
    init(networkConfig: NetworkConfigProtocol = NetworkConfig()) {
        self.networkConfig = networkConfig
    }
    
    func call<R: Encodable, T: Decodable>(request: R, completion: ((Result<T, Error>) -> Void)?) {
        let requestData = try? JSONEncoder().encode(request)
        guard let url = URL(string: self.networkConfig.urlString) else {
            completion?(.failure(APIError.invalidResponse))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = networkConfig.method
        urlRequest.httpBody = requestData
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let httpsResponse = response as? HTTPURLResponse,
                  httpsResponse.statusCode == 200,
                  let data = data else {
                completion?(.failure(APIError.notReachable))
                return
            }
            guard let model = try? JSONDecoder().decode(T.self, from: data) else {
                completion?(.failure(APIError.notReachable))
                return
            }
            completion?(.success(model))
            
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
    var baseURL: String = "https://google.com"
    var path: String?
    var method: String = "POST"
}

enum APIError: Error {
    case invalidResponse
    case notReachable
    
    var errorDescription: String {
        switch self {
            case .invalidResponse:
                return "Something went wrong"
            case .notReachable:
                return "Server is down"
        }
    }
}
