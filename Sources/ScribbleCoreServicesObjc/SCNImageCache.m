/*
See the LICENSE file for this Package licensing information.

Abstract:
Implementation of an Image caching service (objc) used by ScribbleLabApp.
 
Copyright (c) 2024 ScribbleLabApp.
*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SCNImageCache.h"

/**
 Implementation of an Image caching service used by ScribbleLabApp.

 This service caches images retrieved from URLs for faster retrieval in subsequent requests.

 - Author: ScribbleLabApp
 - Copyright: © 2024 ScribbleLabApp.

 */
@implementation SCNImageCache {
    NSURLCache *_cache;
}

/**
 Returns the shared instance of SCNImageCache.

 - Returns: The shared SCNImageCache instance.
 */
+ (instancetype)shared {
    static SCNImageCache *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 Initializes a new SCNImageCache instance.

 - Returns: An initialized SCNImageCache instance.
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        _cache = [[NSURLCache alloc] initWithMemoryCapacity:100 * 1024 * 1024
                                                diskCapacity:500 * 1024 * 1024
                                                    diskPath:nil];
    }
    return self;
}

/**
 Retrieves a cached UIImage for the specified URL, if available.

 - Parameter url: The URL for the image.
 - Returns: The cached UIImage if available, otherwise nil.
 */
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

/**
 Caches the provided image data with the associated response.

 - Parameters:
    - data: The image data to be cached.
    - response: The URL response associated with the image data.
 */
- (void)cacheImageData:(NSData *)data withResponse:(NSURLResponse *)response {
    NSCachedURLResponse *cachedData = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
    [_cache storeCachedResponse:cachedData forRequest:[NSURLRequest requestWithURL:response.URL]];
}

@end
