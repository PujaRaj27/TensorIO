//
//  AlertManager.h
//  DemoApp
//
//  Created by Kumar Anand on 24/09/23.
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface AlertManager : NSObject
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
          viewController:(UIViewController *)viewController
         okActionHandler:(void (^)(void))okActionHandler;


@end

NS_ASSUME_NONNULL_END
