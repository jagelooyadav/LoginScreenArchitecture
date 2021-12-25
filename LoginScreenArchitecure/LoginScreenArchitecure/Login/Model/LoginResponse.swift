//
//  LoginResponse.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 08/10/21.
//

import Foundation
import UIKit

public struct LoginData: Decodable {
    public var accessToken: String
    public var user: User
}

public struct User: Decodable {
    public var firstName: String
    public var lastName: String?
}
