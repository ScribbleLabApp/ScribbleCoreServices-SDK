//
//  Header.h
//  
//
//  Created by Nevio Hirani on 13.04.24.
//

#import <Foundation/Foundation.h>
#import <os/log.h>

NS_ASSUME_NONNULL_BEGIN

/// A class for configuring and accessing logging functionality using Apple's Unified Logging System (OSLog).
///
/// - Requires: iOS 14.0 or later.
///
/// - Tag: SCNLog
API_AVAILABLE(ios(14.0))
@interface SCNLog : NSObject

/// The subsystem to categorize log messages.
@property (nonatomic, copy, readonly) NSString *subsystem;

/// The category within the subsystem to further categorize log messages.
@property (nonatomic, copy, readonly) NSString *category;

/// Initializes a new `SCNLog` instance with the provided subsystem and category.
///
/// - Parameters:
///   - subsystem: The subsystem to categorize log messages. Typically, you'd use the bundle identifier of your app.
///   - category: The category within the subsystem to further categorize log messages.
- (instancetype)initWithSubsystem:(NSString *)subsystem category:(NSString *)category;

/// Accesses the logger associated with this `SCNLog` instance.
///
/// - Returns: A `OSLog` instance configured with the specified subsystem and category.
- (OSLog *)logger;

@end

NS_ASSUME_NONNULL_END
