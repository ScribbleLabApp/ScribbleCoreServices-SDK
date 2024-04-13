//
//  SCNLog.m
//  
//
//  Created by Nevio Hirani on 13.04.24.
//

#import "SCNLog.h"
#import <os/log.h>

@implementation SCNLog

- (instancetype)initWithSubsystem:(NSString *)subsystem category:(NSString *)category {
    self = [super init];
    if (self) {
        _subsystem = [subsystem copy];
        _category = [category copy];
    }
    return self;
}

- (OSLog *)logger {
    return [OSLog logWithSubsystem:self.subsystem category:self.category];
}

@end
