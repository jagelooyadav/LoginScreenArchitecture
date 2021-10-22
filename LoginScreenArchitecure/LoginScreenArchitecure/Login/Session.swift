//
//  Session.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 23/10/21.
//

import Foundation

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
