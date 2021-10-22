//
//  Validator.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 23/10/21.
//

import Foundation

protocol LoginFieldValidator {
    func validateEmail(text: String?) -> Bool
    func validatePassword(text: String?) -> Bool
    func validateRole(text: String?) -> Bool
}

extension LoginFieldValidator {
    func validateEmail(text: String?) -> Bool {
        // put validation logic
        return true
    }
    func validatePassword(text: String?) -> Bool {
        // put validation logic
        return true
    }
    func validateRole(text: String?) -> Bool {
        // put validation logic
        return true
    }
}
