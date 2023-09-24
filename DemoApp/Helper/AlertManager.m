//
//  AlertManager.m
//  DemoApp
//
//  Created by Kumar Anand on 24/09/23.
//

#import "AlertManager.h"

@implementation AlertManager

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
          viewController:(UIViewController *)viewController
         okActionHandler:(void (^)(void))okActionHandler {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // Call the OK action handler block when the "OK" button is tapped
                                                         if (okActionHandler) {
                                                             okActionHandler();
                                                         }
                                                     }];

    [alertController addAction:okAction];

    [viewController presentViewController:alertController animated:YES completion:nil];
}


- (BOOL)arePasswordsMatching:(NSString *)password confirmPassword:(NSString *)confirmPassword {
    return [password isEqualToString:confirmPassword];
}
@end
