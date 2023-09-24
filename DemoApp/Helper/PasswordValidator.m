//
//  PasswordValidator.m
//  DemoApp
//
//  Created by Kumar Anand on 24/09/23.
//

#import "PasswordValidator.h"

@implementation PasswordValidator

+ (BOOL)arePasswordsMatching:(NSString *)password confirmPassword:(NSString *)confirmPassword {
    return [password isEqualToString:confirmPassword];
}
@end
