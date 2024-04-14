//
//  Header.h
//  
//
//  Created by Nevio Hirani on 14.04.24.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// A frozen structure representing a color.
///
/// Use `SCNColor` to represent colors in your package.
///
/// `SCNColor` provides various initializers to create colors using different color models and formats, including RGB, hexadecimal, binary, HSL, CMYK, and CIELAB.
///
/// ### Example Usage:
/// ```objective-c
/// // Create a red color using RGB values
/// SCNColor *redColor = [[SCNColor alloc] initWithRed:255 green:0 blue:0];
///
/// // Create a green color using hexadecimal value
/// SCNColor *greenColor = [[SCNColor alloc] initWithHex:@"#00FF00"];
///
/// // Create a blue color using binary value
/// SCNColor *blueColor = [[SCNColor alloc] initWithBinary:0b00000000_00000000_11111111];
///
/// // Use your package's predefined standard colors
/// SCNColor *yellow = [SCNColor yellowColor];
/// ```
///
/// - Requires: iOS 17.0 or later.
/// - Tag: SCNColor
@interface SCNColor : NSObject

/// The color represented by `SCNColor`.
@property (nonatomic, strong, readonly) UIColor *color;

/// Initializes a `SCNColor` instance with a UIKit `UIColor`.
///
/// - Parameter color: The UIKit `UIColor` to initialize the `SCNColor` instance.
- (instancetype)initWithUIColor:(UIColor *)color;

/// Initializes a `SCNColor` instance with RGB values.
///
/// - Parameters:
///   - red: The red component of the color (0-255).
///   - green: The green component of the color (0-255).
///   - blue: The blue component of the color (0-255).
///   - alpha: The opacity component of the color (0-1).
- (instancetype)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/// Initializes a `SCNColor` instance with a hexadecimal string representing the color.
///
/// - Parameter hex: The hexadecimal string representing the color, with or without the '#' prefix.
- (instancetype)initWithHex:(NSString *)hex;

/// Initializes a `SCNColor` instance with a binary string representing the color.
///
/// - Parameter binary: The binary string representing the color.
- (instancetype)initWithBinary:(NSString *)binary;

/// Initializes a `SCNColor` instance with HSL (Hue, Saturation, Lightness) values.
///
/// - Parameters:
///   - hue: The hue component of the color (0-360).
///   - saturation: The saturation component of the color (0-100).
///   - lightness: The lightness component of the color (0-100).
- (instancetype)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness;

/// Initializes a `SCNColor` instance with CMYK (Cyan, Magenta, Yellow, Black) values.
///
/// - Parameters:
///   - cyan: The cyan component of the color (0-100).
///   - magenta: The magenta component of the color (0-100).
///   - yellow: The yellow component of the color (0-100).
///   - black: The black (key) component of the color (0-100).
- (instancetype)initWithCyan:(CGFloat)cyan magenta:(CGFloat)magenta yellow:(CGFloat)yellow black:(CGFloat)black;

/// Initializes a `SCNColor` instance with CIELAB (CIE 1976 L*a*b*) values.
///
/// - Parameters:
///   - luminance: The luminance (lightness) component of the color (0-100).
///   - a: The a component of the color (-128 to 128).
///   - b: The b component of the color (-128 to 128).
- (instancetype)initWithLuminance:(CGFloat)luminance a:(CGFloat)a b:(CGFloat)b;

/// Predefined black color.
+ (SCNColor *)blackColor;

/// Predefined blue color.
+ (SCNColor *)blueColor;

/// Predefined brown color.
+ (SCNColor *)brownColor;

/// Predefined clear color.
+ (SCNColor *)clearColor;

/// Predefined cyan color.
+ (SCNColor *)cyanColor;

/// Predefined gray color.
+ (SCNColor *)grayColor;

/// Predefined green color.
+ (SCNColor *)greenColor;

/// Predefined indigo color.
+ (SCNColor *)indigoColor;

/// Predefined mint color.
+ (SCNColor *)mintColor;

/// Predefined orange color.
+ (SCNColor *)orangeColor;

/// Predefined pink color.
+ (SCNColor *)pinkColor;

/// Predefined purple color.
+ (SCNColor *)purpleColor;

/// Predefined red color.
+ (SCNColor *)redColor;

/// Predefined teal color.
+ (SCNColor *)tealColor;

/// Predefined white color.
+ (SCNColor *)whiteColor;

/// Predefined yellow color.
+ (SCNColor *)yellowColor;

/// A color that reflects the accent color of the system or app.
+ (SCNColor *)accentColor;

/// The color to use for primary content.
+ (SCNColor *)primaryColor;

/// The color to use for secondary content.
+ (SCNColor *)secondaryColor;

/// Predefined SCN accent color.
+ (SCNColor *)scnAccentColor;

/// Predefined SCN primary color.
+ (SCNColor *)scnPrimaryColor;

/// Predefined SCN secondary color.
+ (SCNColor *)scnSecondaryColor;

/// Predefined SCN blue color.
+ (SCNColor *)scnBlueColor;

/// Predefined SCN gray color.
+ (SCNColor *)scnGrayColor;

/// Predefined SCN orange color.
+ (SCNColor *)scnOrangeColor;

/// Predefined SCN dark orange color.
+ (SCNColor *)scnDarkOrangeColor;

/// Predefined SCN teal color.
+ (SCNColor *)scnTealColor;

/// Predefined SCN purple color.
+ (SCNColor *)scnPurpleColor;

/// Predefined SCN yellow color.
+ (SCNColor *)scnYellowColor;

/// Predefined SCN ghost white color.
+ (SCNColor *)scnGhostWhiteColor;

@end

NS_ASSUME_NONNULL_END
