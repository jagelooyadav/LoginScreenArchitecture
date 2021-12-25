//
//  LoginCoordinator.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 08/10/21.
//

import Foundation
import UIKit

protocol LoginCoordinatorProtocol {
    func next()
}

class LoginCoordinator: Coordinator, LoginCoordinatorProtocol {
    func next() {
        print("next button")
    }
}
