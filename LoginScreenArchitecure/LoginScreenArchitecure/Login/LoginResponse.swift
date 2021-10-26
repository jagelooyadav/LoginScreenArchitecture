//
//  LoginResponse.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 08/10/21.
//

import Foundation
import UIKit

struct LoginData: Decodable {
    var accessToken: String
    var user: User
}

struct User: Decodable {
    var firstName: String
    var lastName: String?
}
