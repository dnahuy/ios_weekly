//
//  ContainerNavigator.swift
//  Web3AuthITW
//
//  Created by anhhuy.du on 20/04/2024.
//

import Foundation
import UIKit


// https://stackoverflow.com/questions/42516357/how-does-googles-custom-ios-keyboard-gboard-programmatically-dismiss-the-fron
@objc private protocol PrivateSelectors: NSObjectProtocol {
    var destinations: [NSNumber] { get }
    func sendResponseForDestination(_ destination: NSNumber)
}

private func jumpBackToPreviousApp() -> Bool {
    if #available(iOS 17.0, *) {
        let lastAppBundleId = PersistentStore.hostBundleId
        PersistentStore.removeHostBundleId()
        
        guard let obj = objc_getClass("LSApplicationWorkspace") as? NSObject else { return false }
        let workspace = obj.perform(Selector(("defaultWorkspace")))?.takeUnretainedValue() as? NSObject
        let open = workspace?.perform(Selector(("openApplicationWithBundleID:")), with: lastAppBundleId) != nil
        return open
    } else {
        guard
            let sysNavIvar = class_getInstanceVariable(UIApplication.self, "_systemNavigationAction"),
            let action = object_getIvar(UIApplication.shared, sysNavIvar) as? NSObject,
            let destinations = action.perform(#selector(getter: PrivateSelectors.destinations)).takeUnretainedValue() as? [NSNumber],
            let firstDestination = destinations.first
        else {
            return false
        }
        action.perform(#selector(PrivateSelectors.sendResponseForDestination), with: firstDestination)
        return true
    }
}

final class ContainerNavigator {
    static func backToExtension() {
        _ = jumpBackToPreviousApp()
    }
}
