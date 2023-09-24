//
//  RegiViewController.m
//  DemoApp
//
//  Created by Kumar Anand on 24/09/23.
//

#import "RegiViewController.h"
#import "ProfileViewController.h"
#import <AVFoundation/AVFoundation.h>
@import FirebaseAuth;
#import "UITextField+BottomLine.h"
#import "AlertManager.h"
#import "PasswordValidator.h"

@interface RegiViewController ()
@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;

@end

@implementation RegiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addButton] ;
    [self addTextField] ;
    // Do any additional setup after loading the view.
}

NSData *imageData;
UIImage *img;
- (void)viewDidAppear:(BOOL)animated {
[super viewDidAppear:animated];
self.captureSession = [AVCaptureSession new];
self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
AVCaptureDevice *backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
if (!backCamera) {
    NSLog(@"Unable to access back camera!");
    return;
}

NSError *error;
AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera
                                                                    error:&error];
if (!error) {
    self.stillImageOutput = [AVCapturePhotoOutput new];
    if ([self.captureSession canAddInput:input] && [self.captureSession canAddOutput:self.stillImageOutput]) {
        
        [self.captureSession addInput:input];
        [self.captureSession addOutput:self.stillImageOutput];
        [self setupLivePreview];
    }
}
else {
    NSLog(@"Error Unable to initialize back camera: %@", error.localizedDescription);
}

}

-(void)addTextField{
    [_emailTxt addBottomLine];
    [_passwordTxt addBottomLine];
    [_userNameTxt addBottomLine];
    [_confirmPasswordTxt addBottomLine] ;
    [_shortBio addBottomLine];
    _emailTxt.placeholder = @"Email" ;
    _passwordTxt.placeholder = @"Password" ;
    _confirmPasswordTxt.placeholder = @"Confirm Password" ;
    _userNameTxt.placeholder = @"User Name";
    _shortBio.placeholder = @"A short Bio" ;
    
}

-(void)addButton{
    _signUpBtn.layer.cornerRadius = 5 ;
}

- (void)setupLivePreview {

self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
if (self.videoPreviewLayer) {
    
    self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    [self.previewView.layer addSublayer:self.videoPreviewLayer];
    
    
    dispatch_queue_t globalQueue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(globalQueue, ^{
        [self.captureSession startRunning];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.videoPreviewLayer.frame = self.previewView.bounds;
        });
    });
}
}

- (IBAction)setDisplayAction:(UIButton *)sender {
    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey: AVVideoCodecTypeJPEG}];
   [self.stillImageOutput capturePhotoWithSettings:settings delegate:self];
}

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error {
    imageData = photo.fileDataRepresentation;
    if (imageData) {
        UIImage *image = [UIImage imageWithData:imageData];
//        img = image;
//        // Add the image to captureImageView here...
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.captureSession stopRunning];
}

- (IBAction)signUpBtnAction:(UIButton *)sender {
    
//    if (imageData == nil){
//
//        UIAlertController * alert = [UIAlertController
//                                     alertControllerWithTitle:@"Next Screen"
//                                     message:@"Image data is Empty.Please capture image"
//                                     preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction* noButton = [UIAlertAction
//                                   actionWithTitle:@"Cancel"
//                                   style:UIAlertActionStyleDefault
//                                   handler:^(UIAlertAction * action) {
//
//        }];
//
//        [alert addAction:noButton];
//
//        [self presentViewController:alert animated:YES completion:nil];
//
//    }
//
//    else{
    
    
    if ([PasswordValidator arePasswordsMatching:_passwordTxt.text confirmPassword:_confirmPasswordTxt.text]) {
        // Passwords match, proceed with registration or other actions
        NSLog(@"Passwords match!");
    } else {
        // Passwords do not match, display an error message to the user
        
        [AlertManager showAlertWithTitle:@"Password" message:@"Passwords do not match. Please try again." viewController:self okActionHandler:^{
            NSLog(@"OK button tapped, performing navigation...");
        }];
    }
    
    
    
    // Register a new user
    [[FIRAuth auth] createUserWithEmail: _emailTxt.text  password:_passwordTxt.text
        completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            if (error) {
                [AlertManager showAlertWithTitle:@"AuthResult" message:error.localizedDescription viewController:self okActionHandler:^{
                    NSLog(@"OK button tapped, performing navigation...");
                }];
            } else {
                [AlertManager showAlertWithTitle:@"AuthResult" message:@"Success" viewController:self okActionHandler:^{
                    // Add your navigation code here
                    NSLog(@"OK button tapped, performing navigation...");
                    NSLog(@"Sign up successful. User ID: %@", authResult.user.uid);
                    NSString * storyboardName = @"Main";
                       UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
                       ProfileViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                       vc.imgData = imageData;
                       vc.name = _userNameTxt.text ;
                       vc.shortBio = _shortBio.text ;
                       [self.navigationController pushViewController:vc animated:YES];
                }];
                
            }
        }];

   // }
  
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
