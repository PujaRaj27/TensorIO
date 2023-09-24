//
//  ProfileViewController.h
//  DemoApp
//
//  Created by Kumar Anand on 22/09/23.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property(nonatomic,strong) NSArray *weatherArray;
@property (weak, nonatomic) IBOutlet UITableView *weatherListTableView;
@property (strong, nonatomic) CLLocationManager *LocationManager;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property(nonatomic,weak) NSData *imgData;
@property (weak, nonatomic) IBOutlet UIButton *changeCityBtn;
@property(weak,nonatomic) NSString *name ;
@property(weak,nonatomic) NSString *shortBio ;


@end

NS_ASSUME_NONNULL_END
