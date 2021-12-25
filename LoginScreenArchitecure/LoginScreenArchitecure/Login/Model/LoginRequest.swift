//
//  LoginRequest.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 08/10/21.
//

import Foundation

public struct LoginRequest: Encodable {
    public var userName: String?
    public var password: String?
    public var userRole: String?
}
