//
//  File.swift
//  MyFirstMobileApp
//
//  Created by Jageloo Yadav on 16/10/21.
//

import Foundation

class A {
    //varaibles
    
    var rollNumbner: Int
    var var1: String?
    
    // Computed
    var rollnumberMultiplier: Int {
        return self.rollNumbner * 4
    }
    
    var computed1: Int {
        get {
            return self.rollNumbner
        }
        
        set {
            print("new value === \(newValue)")
            self.rollNumbner = newValue
        }
    }
    
    func call() {
        
    }
    


    // initialisers
    init() {
        rollNumbner = 10
    }
    
    init(paramerter: Int) {
        rollNumbner = paramerter
    }
    
    /// private func
    
}
// types of property
// 1 - computed
// 2- strored



