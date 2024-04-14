/*
See the LICENSE file for this Package licensing information.

Abstract:
NetworkMonitor used by ScribbleLabApp
 
Copyright (c) 2024 ScribbleLabApp.
*/

import Foundation
import Network

/// A class responsible for monitoring the device's network connectivity.
///
/// This class utilizes NWPathMonitor to observe changes in the network path
/// and updates the `isInternetConnected` property based on the current network status.
///
public class SCNNetworkMonitor {
    /// A property indicating whether the device is currently connected to the internet.
    public private(set) var isInternetConnected = false
    
    private let monitor = NWPathMonitor()
    private let monitorQueue = DispatchQueue(label: "NetworkMonitor")
    
    /// Initializes the network monitoring process and begins monitoring the network status.
    public init() {
        startMonitoring()
    }
    
    /// Starts monitoring the network status using NWPathMonitor.
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isInternetConnected = path.status == .satisfied
            }
        }
        
        monitor.start(queue: monitorQueue)
    }
}
