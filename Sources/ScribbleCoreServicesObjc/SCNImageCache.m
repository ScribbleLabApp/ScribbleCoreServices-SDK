//
//  SCNImageCache.m
//  
//
//  Created by Nevio Hirani on 14.04.24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SCNImageCache.h"

@implementation SCNImageCache {
    NSURLCache *_cache;
}

+ (instancetype)shared {
    static SCNImageCache *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _cache = [[NSURLCache alloc] initWithMemoryCapacity:100 * 1024 * 1024
                                                diskCapacity:500 * 1024 * 1024
                                                    diskPath:nil];
    }
    return self;
}

- (UIImage *)getCachedImageWithURL:(NSURL *)url {
    NSCachedURLResponse *cachedResponse = [_cache cachedResponseForRequest:[NSURLRequest requestWithURL:url]];
    if (cachedResponse) {
        UIImage *uiImage = [UIImage imageWithData:cachedResponse.data];
        if (uiImage) {
            return uiImage;
        }
    }
    return nil;
}

- (void)cacheImageData:(NSData *)data withResponse:(NSURLResponse *)response {
    NSCachedURLResponse *cachedData = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
    [_cache storeCachedResponse:cachedData forRequest:[NSURLRequest requestWithURL:response.URL]];
}

@end
