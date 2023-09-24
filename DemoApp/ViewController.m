//
//  ViewController.m
//  DemoApp
//
//  Created by Kumar Anand on 22/09/23.
//

#import "ViewController.h"
@import FirebaseAuth;
#import "UITextField+BottomLine.h"
#import "WeatherRadar.h"
#import "RegiViewController.h"
#import "AlertManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Create an email/password-based user account
    [ self addTextField];
    [ self addButton];

}

-(void)addTextField{
    [_emailTextField addBottomLine];
    [_PasswordTextField addBottomLine];
    _emailTextField.placeholder = @"Email" ;
    _PasswordTextField.placeholder = @"Password" ;
}

-(void)addButton{
    _loginBtn.layer.cornerRadius = 5 ;
    _signUpBtn.layer.cornerRadius = 5 ;
}


- (IBAction)loginBtnAction:(UIButton *)sender {
    
    // Sign in an existing user
    [[FIRAuth auth] signInWithEmail:_emailTextField.text password:_PasswordTextField.text
        completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            if (error) {
                [AlertManager showAlertWithTitle:@"AuthResult" message:error.localizedDescription viewController:self okActionHandler:^{
                    // Add your navigation code here
                    NSLog(@"OK button tapped, performing navigation...");
                  
                }];
            } else {
                [AlertManager showAlertWithTitle:@"AuthResult" message:@"Success" viewController:self okActionHandler:^{
                    // Add your navigation code here
                   
                    NSLog(@"Sign up successful. User ID: %@", authResult.user.uid);
                }];
            }
        }];
    

    
}
- (IBAction)signUpBtnAction:(UIButton *)sender {
    RegiViewController *objshowDataVc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegiViewController"];
    [self.navigationController pushViewController:objshowDataVc animated:YES];
}



@end
