//
//  ViewController.swift
//  MyFirstMobileApp
//
//  Created by Jageloo Yadav on 13/10/21.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        let a = A(paramerter: 20)
        a.computed1 = 20
        
        print(a.computed1)
        
        let b = a
        b.computed1 = 30
        print(a.rollNumbner)
        
    }
    @IBOutlet var label1: UILabel?
    @IBOutlet var label2: UILabel?
    @IBOutlet var label3: UILabel?
    @IBOutlet var label4: UILabel?
    
    @IBAction func buttonClick() {
        print("button click")
        label1?.backgroundColor = .red
        label1?.text = "Shyamu"
    }
    @IBAction func buttonLogin(){
        print("Login Button")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
}

