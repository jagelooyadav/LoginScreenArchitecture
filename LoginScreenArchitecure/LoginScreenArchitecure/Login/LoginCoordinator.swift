//
//  LoginCoordinator.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 08/10/21.
//

import Foundation
import UIKit

protocol LoginCoordinatorProtocol: class {
    func next()
}

class LoginCoordinator: LoginCoordinatorProtocol {
    func next() {
        print("next button")
    }
    
    init(root: UINavigationController) {
        
    }
}
