//
//  File.swift
//  
//
//  Created by Nevio Hirani on 11.05.24.
//

import Foundation
import UserNotifications

public protocol SCSNotificationAgent: AnyObject {
    var notificationPermissionStatus: UNAuthorizationStatus { get set }
    
    func requestNotificationPermission()
}
