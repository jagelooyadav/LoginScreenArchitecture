//
//  ObservableTextField.swift
//  LoginScreenArchitecure
//
//  Created by Jageloo Yadav on 09/10/21.
//

import Foundation
import UIKit
import Combine

extension UIControl {
    struct EventPublisher: Publisher {
        typealias Output = UIControl
        typealias Failure = Never
        
        fileprivate var control: UIControl
        
        fileprivate var event: Event
        
        func receive<S: Subscriber>(
            subscriber: S
        ) where S.Input == Output, S.Failure == Failure {
            let subscription = EventSubscription<S>()
            subscription.target = subscriber
            subscription.control = control
            subscriber.receive(subscription: subscription)
            control.addTarget(subscription,
                              action: #selector(subscription.trigger),
                              for: event
            )
        }
    }
    
    class EventSubscription<Target: Subscriber>: Subscription
    where Target.Input == UIControl {
        
        var target: Target?
        var control: UIControl!
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            target = nil
        }
        
        @objc func trigger() {
            _ = target?.receive(control)
        }
    }
    
    func publisher(for event: Event) -> EventPublisher {
        EventPublisher(
            control: self,
            event: event
        )
    }
}

extension UITextField {
    var textChange: AnyPublisher<String, Never> {
        publisher(for: .editingChanged)
            .map { ($0 as? UITextField)?.text ?? "" }
            .eraseToAnyPublisher()
    }
}

extension UIButton {
    var actionPublisher: AnyPublisher<UIButton, Never> {
        publisher(for: .touchUpInside)
            .map { $0 as? UIButton ?? UIButton() }
            .eraseToAnyPublisher()
    }
}
