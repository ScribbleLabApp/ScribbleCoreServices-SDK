/*
See the LICENSE file for this Package licensing information.

Abstract:
Declaration of ImageCaching service (objc) used by ScribbleLabApp.
 
Copyright (c) 2024 ScribbleLabApp.
*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_SWIFT_NAME(SCNImageCache)
@interface SCNImageCache : NSObject

/// Returns the shared instance of the image cache.
@property (class, nonatomic, readonly) SCNImageCache *shared;

/// Retrieves the cached image for the specified URL.
///
/// @param url The URL of the image.
/// @return An instance of `UIImage` if the image is cached, otherwise `nil`.
- (nullable UIImage *)getCachedImageWithURL:(NSURL *)url;

/// Caches the image data with the associated response.
///
/// @param data     The image data to be cached.
/// @param response The URL response associated with the image data.
- (void)cacheImageData:(NSData *)data withResponse:(NSURLResponse *)response;

@end
