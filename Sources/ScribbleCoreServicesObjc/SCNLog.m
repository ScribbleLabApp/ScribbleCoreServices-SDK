/*
See the LICENSE file for this Package licensing information.

Abstract:
Implementation of Core Logging Service (objc) used by ScribbleLabApp.
 
Copyright (c) 2024 ScribbleLabApp.
*/

#import "SCNLog.h"

/**
 Implementation of Core Logging Service (objc) used by ScribbleLabApp.

 This service allows reliable and easy logging throughout your app.

 - Author: ScribbleLabApp
 - Copyright: © 2024 ScribbleLabApp.

 */
@implementation SCNLog

/**
 Initializes a new SCNLog instance with the specified subsystem.

 @param subsystem The subsystem to categorize log messages.
 @return An initialized SCNLog instance.
 */
- (instancetype)initWithSubsystem:(NSString *)subsystem {
    self = [super init];
    if (self) {
        _subsystem = [subsystem copy];
    }
    return self;
}

/**
 Creates a logger for the specified category within the subsystem.

 @param category The category to further categorize log messages.
 @return An os_log_t object representing the logger.
 */
- (os_log_t)loggerForCategory:(NSString *)category {
    return os_log_create([self.subsystem UTF8String], [category UTF8String]);
}

@end
