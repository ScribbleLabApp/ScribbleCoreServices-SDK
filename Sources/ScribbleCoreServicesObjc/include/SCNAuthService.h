//
//  Header.h
//  
//
//  Created by Nevio Hirani on 14.04.24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Protocol defining authentication service methods.
@protocol SCNAuthService <NSObject>

/// Attempts to log in with the provided email and password asynchronously.
///
/// @param email The email for login.
/// @param password The password for login.
- (void)logInWithEmail:(NSString *)email password:(NSString *)password completionHandler:(void (^)(NSError * _Nullable error))completionHandler;

/// Creates a new user account with the provided email, password, and username.
///
/// This function attempts to create a new user account with the given email, password, and username asynchronously.
///
/// @param email The email for the new user account.
/// @param password The password for the new user account.
/// @param username The username for the new user account.
/// @param completionHandler A completion handler to be called after the operation completes.
- (void)createUserWithEmail:(NSString *)email password:(NSString *)password username:(NSString *)username completionHandler:(void (^)(NSError * _Nullable error))completionHandler;

/// Loads user data for the currently authenticated user.
///
/// This function asynchronously loads user data for the currently authenticated user.
/// It retrieves user session information and fetches the corresponding user data based on the session UID.
/// The loaded user information includes details like username, email, etc.
///
/// @param completionHandler A completion handler to be called after the operation completes.
- (void)loadUserDataWithCompletionHandler:(void (^)(NSError * _Nullable error))completionHandler;

/// Signs the current user out of the application.
///
/// This function signs out the current user session from the application.
/// It revokes the authentication session and clears any user-related data in the app.
///
/// The function sets the user session and current user information to `nil` after sign-out.
///
- (void)signOut;

/// Sends a password reset request for the provided email.
///
/// This function initiates a password reset request for the given email address.
///
/// @param email The email address for which the password reset is requested.
/// @param completionHandler A completion handler to be called after the operation completes.
- (void)resetPasswordWithEmail:(NSString *)email completionHandler:(void (^)(BOOL success, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
