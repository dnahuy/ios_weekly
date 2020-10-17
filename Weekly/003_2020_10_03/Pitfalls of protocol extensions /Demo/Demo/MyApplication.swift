//
//  MyApplication.swift
//  Demo
//
//  Created by Huy Du on 10/5/20.
//

import UIKit

class MyApplication: UIApplication {
    override func sendEvent(_ event: UIEvent) {
        print("sendEvent: \(event)")
        super.sendEvent(event)
    }

    override func sendAction(
        _ action: Selector,
        to target: Any?,
        from sender: Any?,
        for event: UIEvent?
    ) -> Bool {
        print("sendAction: \(action)")
        return super.sendAction(
            action,
            to: target,
            from: sender,
            for: event)
    }
}
