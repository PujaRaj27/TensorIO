//
//  DescriptionViewController.h
//  DemoApp
//
//  Created by Kumar Anand on 23/09/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DescriptionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLbl;
@property (weak, nonatomic) IBOutlet UILabel *airHumidityLbl;
@property (nonatomic) int humidity;
@property (nonatomic) float speed;
@end

NS_ASSUME_NONNULL_END
