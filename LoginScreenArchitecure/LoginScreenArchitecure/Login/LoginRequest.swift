//
//  LoginRequest.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 08/10/21.
//

import Foundation

struct LoginRequest: Encodable {
    var userName: String?
    var password: String?
    var userRole: String?
}
