//
//  LoginViewController.swift
//  MyFirstMobileApp
//
//  Created by Jageloo Yadav on 14/10/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var userNameTextField: UITextField?
    @IBOutlet var passwordTextField:UITextField?
    
    var closure: (() -> Void)?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // (Int) -> Void)
        
        let clouse = { (item) -> Void in
            print(item)
        }
        
        self.myFunc(myblock: clouse)
        
        let a: Int? = 10
        print(a)
        if let a = a {
            print(a)
        } else {
        }
    }
    
    func myFunc(myblock: ((Int) -> Void)?) {
        myblock?(10)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func login() {
        print("Testing 123")
        
    }
    @IBAction func rememberMe() {
        print("Testing Swift")
        
    }
    
    @IBAction func signUP() {
        print("1234")
        
    }
    
    @IBAction func Forgot_Password(){
        print("Password")
    }
}
