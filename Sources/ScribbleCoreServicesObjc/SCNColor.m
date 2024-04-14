/*
See the LICENSE file for this Package licensing information.

Abstract:
Implementation of ScribbleLabApp's own SwiftUI Color like implementation (objc)
 
Copyright (c) 2024 ScribbleLabApp.
*/

#import <Foundation/Foundation.h>
#import "SCNColor.h"

/**
 Implementation of ScribbleLab's own colo implementation used by ScribbleLabApp.

 This service caches images retrieved from URLs for faster retrieval in subsequent requests.

 - Author: ScribbleLabApp
 - Copyright: © 2024 ScribbleLabApp.

 */
@implementation SCNColor

- (instancetype)initWithUIColor:(UIColor *)color {
    self = [super init];
    if (self) {
        _color = color;
    }
    return self;
}

- (instancetype)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue { // FIXME: Add alpha:(CGFloat)alpha;
    return [self initWithUIColor:[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0]];
}

- (instancetype)initWithCyan:(CGFloat)cyan magenta:(CGFloat)magenta yellow:(CGFloat)yellow black:(CGFloat)black {
    CGFloat red = (1 - MIN(1, cyan * (1 - black / 100.0) + black / 100.0)) * 255.0;
    CGFloat green = (1 - MIN(1, magenta * (1 - black / 100.0) + black / 100.0)) * 255.0;
    CGFloat blue = (1 - MIN(1, yellow * (1 - black / 100.0) + black / 100.0)) * 255.0;
    
    return [self initWithRed:red green:green blue:blue];
}

- (instancetype)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness {
    CGFloat chroma = (1 - fabs(2 * lightness - 1)) * saturation;
    CGFloat huePrime = hue / 60.0;
    CGFloat x = chroma * (1 - fabs(fmod(huePrime, 2) - 1));
    
    CGFloat r, g, b;
    if (0 <= huePrime && huePrime < 1) {
        r = chroma;
        g = x;
        b = 0;
    } else if (1 <= huePrime && huePrime < 2) {
        r = x;
        g = chroma;
        b = 0;
    } else if (2 <= huePrime && huePrime < 3) {
        r = 0;
        g = chroma;
        b = x;
    } else if (3 <= huePrime && huePrime < 4) {
        r = 0;
        g = x;
        b = chroma;
    } else if (4 <= huePrime && huePrime < 5) {
        r = x;
        g = 0;
        b = chroma;
    } else {
        r = chroma;
        g = 0;
        b = x;
    }
    
    CGFloat m = lightness - chroma / 2;
    return [self initWithRed:(r + m) * 255.0 green:(g + m) * 255.0 blue:(b + m) * 255.0];
}

- (instancetype)initWithLuminance:(CGFloat)luminance a:(CGFloat)a b:(CGFloat)b {
    CGFloat y = (luminance + 16) / 116.0;
    CGFloat x = a / 500.0 + y;
    CGFloat z = y - b / 200.0;
    
    CGFloat r = [self adjustXYZColorComponent:x];
    CGFloat g = [self adjustXYZColorComponent:y];
    CGFloat bl = [self adjustXYZColorComponent:z];
    
    return [self initWithRed:r * 255.0 green:g * 255.0 blue:bl * 255.0];
}

- (CGFloat)adjustXYZColorComponent:(CGFloat)value {
    CGFloat adjustedValue = pow(value, 3);
    return adjustedValue > 0.0031308 ? 1.055 * pow(adjustedValue, 1.0 / 2.4) - 0.055 : 12.92 * adjustedValue;
}

- (instancetype)initWithHex:(NSString *)hex {
    NSString *hexString = [hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    unsigned int rgb = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgb];
    
    CGFloat red = ((rgb & 0xFF0000) >> 16) / 255.0;
    CGFloat green = ((rgb & 0x00FF00) >> 8) / 255.0;
    CGFloat blue = (rgb & 0x0000FF) / 255.0;
    
    return [self initWithRed:red green:green blue:blue];
}

- (instancetype)initWithBinary:(NSString *)binary {
    NSInteger decimal = strtol([binary UTF8String], NULL, 2);
    NSString *hexString = [NSString stringWithFormat:@"%06lx", (long)decimal];
    return [self initWithHex:hexString];
}

+ (SCNColor *)blackColor {
    return [[SCNColor alloc] initWithRed:0 green:0 blue:0];
}

+ (SCNColor *)blueColor {
    return [[SCNColor alloc] initWithRed:0 green:0 blue:255];
}

+ (SCNColor *)brownColor {
    return [[SCNColor alloc] initWithRed:165 green:42 blue:42];
}

+ (SCNColor *)clearColor {
    return [[SCNColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
}

+ (SCNColor *)cyanColor {
    return [[SCNColor alloc] initWithRed:0 green:255 blue:255];
}

+ (SCNColor *)grayColor {
    return [[SCNColor alloc] initWithRed:128 green:128 blue:128];
}

+ (SCNColor *)greenColor {
    return [[SCNColor alloc] initWithRed:0 green:128 blue:0];
}

+ (SCNColor *)indigoColor {
    return [[SCNColor alloc] initWithRed:75 green:0 blue:130];
}

+ (SCNColor *)mintColor {
    return [[SCNColor alloc] initWithRed:0 green:255 blue:127];
}

+ (SCNColor *)orangeColor {
    return [[SCNColor alloc] initWithRed:255 green:165 blue:0];
}

+ (SCNColor *)pinkColor {
    return [[SCNColor alloc] initWithRed:255 green:192 blue:203];
}

+ (SCNColor *)purpleColor {
    return [[SCNColor alloc] initWithRed:128 green:0 blue:128];
}

+ (SCNColor *)redColor {
    return [[SCNColor alloc] initWithRed:255 green:0 blue:0];
}

+ (SCNColor *)tealColor {
    return [[SCNColor alloc] initWithRed:0 green:128 blue:128];
}

+ (SCNColor *)whiteColor {
    return [[SCNColor alloc] initWithRed:255 green:255 blue:255];
}

+ (SCNColor *)yellowColor {
    return [[SCNColor alloc] initWithRed:255 green:255 blue:0];
}

+ (SCNColor *)accentColor {
    // Implement accent color logic here...
}

+ (SCNColor *)primaryColor {
    // Implement primary color logic here...
}

+ (SCNColor *)secondaryColor {
    // Implement secondary color logic here...
}

+ (SCNColor *)scnAccentColor {
    // Implement SCN accent color logic here...
}

+ (SCNColor *)scnPrimaryColor {
    // Implement SCN primary color logic here...
}

+ (SCNColor *)scnSecondaryColor {
    // Implement SCN secondary color logic here...
}

+ (SCNColor *)scnBlueColor {
    return [[SCNColor alloc] initWithHex:@"#2A97FF"];
}

+ (SCNColor *)scnGrayColor {
    return [[SCNColor alloc] initWithHex:@"#888"];
}

+ (SCNColor *)scnOrangeColor {
    return [[SCNColor alloc] initWithHex:@"#ED8335"];
}

+ (SCNColor *)scnDarkOrangeColor {
    return [[SCNColor alloc] initWithHex:@"#F48044"];
}

+ (SCNColor *)scnTealColor {
    return [[SCNColor alloc] initWithHex:@"#43B9B9"];
}

+ (SCNColor *)scnPurpleColor {
    return [[SCNColor alloc] initWithHex:@"#A972FF"];
}

+ (SCNColor *)scnYellowColor {
    return [[SCNColor alloc] initWithHex:@"#FFBF45"];
}

+ (SCNColor *)scnGhostWhiteColor {
    return [[SCNColor alloc] initWithHex:@"#F8F7FF"];
}

@end
