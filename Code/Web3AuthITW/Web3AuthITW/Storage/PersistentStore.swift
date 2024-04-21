//
//  PersistentStore.swift
//  Web3AuthITW
//
//  Created by anhhuy.du on 20/04/2024.
//

import Foundation

final class PersistentStore {
    private static let groupIdentifier = "group.w3authwhisper"
    private static let hostAppIdKey = "last_app_bundle_id"
    private static let translationFileName = "translation.txt"
    private static let textIdFileName = "text_id.txt"

    private static var translationURL: URL {
        FileManager
            .default
            .containerURL(
                forSecurityApplicationGroupIdentifier: groupIdentifier)!
            .appendingPathComponent(translationFileName)
    }
    
    private static var textIdURL: URL {
        FileManager
            .default
            .containerURL(
                forSecurityApplicationGroupIdentifier: groupIdentifier)!
            .appendingPathComponent(textIdFileName)
    }
    
    private static var userDefaults: UserDefaults? {
        UserDefaults(suiteName: groupIdentifier)
    }
    
    static var translatedText: String? {
        do {
            return try String(contentsOf: translationURL)
        }
        catch {
            return nil
        }
    }
    
    static var textId: String? {
        do {
            return try String(contentsOf: textIdURL)
        }
        catch {
            return nil
        }
    }
    
    static var hostBundleId: String? {
        userDefaults?.string(forKey: hostAppIdKey)
    }
    
    static func save(translatedText: String) {
        do {
            try Data(translatedText.utf8)
                .write(to: translationURL, options: [.atomic])
            try Data(UUID().uuidString.utf8)
                .write(to: textIdURL, options: [.atomic])
        } catch { }
    }

    static func save(hostBundleId: String?) {
        userDefaults?.set(hostBundleId, forKey: hostAppIdKey)
    }
    
    static func removeHostBundleId() {
        userDefaults?.removeObject(forKey: hostAppIdKey)
    }
}
