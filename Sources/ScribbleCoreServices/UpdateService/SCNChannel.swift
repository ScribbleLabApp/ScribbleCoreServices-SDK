//
//  File.swift
//  
//
//  Created by Nevio Hirani on 01.05.24.
//

import Foundation

@available(iOS 17.0, macOS 14.0, *)
public enum SCNChannel: String {
    case stable
    case pre_release
    
    /// Reads the subscribed channel from UserDefaults.
    public static var subscribed: SCNChannel? {
        guard let channelString = UserDefaults.standard.string(forKey: "SubscribedChannel") else {
            return nil
        }
        return SCNChannel(rawValue: channelString)
    }
    
    /// Writes the subscribed channel to UserDefaults.
    public func setAsSubscribed() {
        UserDefaults.standard.set(rawValue, forKey: "SubscribedChannel")
    }
}
