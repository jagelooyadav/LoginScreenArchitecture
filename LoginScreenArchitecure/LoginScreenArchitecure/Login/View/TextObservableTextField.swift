//
//  ObservableTextField.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 09/10/21.
//

import Foundation
import UIKit
import Combine

class TextObservableTextField: UITextField {
    @Published var string: String?
    
    var textDidChange: ((String?) -> Void)?
    private var cancellable = Set<AnyCancellable>()
    
    enum Status {
        case success
        case fail
        case normal
    }
    
    var status: Status = .normal
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    func setup() {
        let pub = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text }
            .sink { text in
                self.string = text
                self.textFieldDidChange()
            }
        pub.store(in: &cancellable)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    @objc func textFieldDidChange() {
        self.textDidChange?(self.text)
    }
}
