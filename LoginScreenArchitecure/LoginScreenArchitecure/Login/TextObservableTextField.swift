//
//  ObservableTextField.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 09/10/21.
//

import Foundation
import UIKit

class TextObservableTextField: UITextField {
    
    var textDidChange: ((String?) -> Void)?
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    func setup() {
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.autocorrectionType = .no
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    @objc func textFieldDidChange() {
        self.textDidChange?(self.text)
    }
}
