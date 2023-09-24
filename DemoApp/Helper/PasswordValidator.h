//
//  PasswordValidator.h
//  DemoApp
//
//  Created by Kumar Anand on 24/09/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PasswordValidator : NSObject
+ (BOOL)arePasswordsMatching:(NSString *)password confirmPassword:(NSString *)confirmPassword;
@end

NS_ASSUME_NONNULL_END
