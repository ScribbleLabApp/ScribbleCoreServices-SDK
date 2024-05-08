//
//  File.swift
//  
//
//  Created by Nevio Hirani on 01.05.24.
//

import Foundation
import SwiftUI

@available(iOS 17.0, macOS 17.0, *)
public extension View {
    /// Subscribes to the specified channel and stores the selection in UserDefaults.
    ///
    /// - Parameters:
    ///     - channel: The channel to subscribe to.
    func subscribeToChannel(channel: String) {
        guard let scnChannel = SCNChannel(rawValue: channel) else {
            fatalError("SCN_ERR: Invalid channel")
        }
        
        /// Use the setAsSubscribed method to store the channel in UserDefaults
        scnChannel.setAsSubscribed()
    }
}
