//
//  SCNLog.m
//  
//
//  Created by Nevio Hirani on 13.04.24.
//

#import "SCNLog.h"

@implementation SCNLog

- (instancetype)initWithSubsystem:(NSString *)subsystem {
    self = [super init];
    if (self) {
        _subsystem = [subsystem copy];
    }
    return self;
}

- (os_log_t)loggerForCategory:(NSString *)category {
    return os_log_create([self.subsystem UTF8String], [category UTF8String]);
}

@end
