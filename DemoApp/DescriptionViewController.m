//
//  DescriptionViewController.m
//  DemoApp
//
//  Created by Kumar Anand on 23/09/23.
//

#import "DescriptionViewController.h"

@interface DescriptionViewController ()


@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *humidity = [NSString stringWithFormat:@"%d", _humidity];
    _airHumidityLbl.text = [@"Humidity = " stringByAppendingFormat:@"%@", humidity];
    
    NSString *speed = [NSString stringWithFormat:@"%f", _speed];
    _windSpeedLbl.text = [@"Speed = " stringByAppendingFormat:@"%@", speed];
    
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
