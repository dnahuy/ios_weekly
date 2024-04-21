//
//  ExtensionNavigator.swift
//  Web3AuthITW
//
//  Created by anhhuy.du on 21/04/2024.
//

import Foundation
import UIKit

// https://medium.com/@abhishekthapliyal/very-helpful-tutorial-8bd045c33f39
final class ExtensionNavigator {
    static func navigateToContainingApp(
        viewController: UIViewController,
        extensionContext: NSExtensionContext
    ) {
        let url = URL(string: "w3authwhisper://")
        var responder = viewController as UIResponder?
        let selectorOpenURL = sel_registerName("openURL:")
        
        while (responder != nil) {
            if (responder?.responds(to: selectorOpenURL))! {
                let _ = responder?.perform(selectorOpenURL, with: url)
            }
            responder = responder!.next
        }
        
        extensionContext.completeRequest(returningItems: [], completionHandler: nil)
    }
}
