//
//  ProfileViewController.m
//  DemoApp
//
//  Created by Kumar Anand on 22/09/23.
//

#import "ProfileViewController.h"
#import "WeatherRadar.h"
#import "Weather.h"
#import "myCustomCell.h"
#import "DescriptionViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *myCustomCell;
@end

@implementation ProfileViewController
@synthesize LocationManager ;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height /2;
    self.profileImage.layer.masksToBounds = YES;
    self.profileImage.layer.borderWidth = 0;
    UIImage *image = [UIImage imageWithData:_imgData];
   
    // Add the image to captureImageView here...
    self.profileImage.image = image;
    _nameLabel.text = _name ;
    _bioLabel.text = _shortBio ;
    _weatherListTableView.delegate = self ;
    _weatherListTableView.dataSource = self ;
    
   /* WeatherRadar *weatherService = [[WeatherRadar alloc] init]; // Create an instance
    float latitude = 37.7749; // Replace with your desired latitude
    float longitude = -122.4194; // Replace with your desired longitude

    [weatherService getWeeklyWeather:latitude
                           longitude:longitude
                     completionBlock:^(NSArray *weeklyWeather) {
        // Handle the weekly weather data here
        NSLog(@"Received weekly weather data: %@", weeklyWeather);
        _weatherArray = weeklyWeather ;
        NSLog(@"Count:%lu",_weatherArray.count) ;
        _weatherListTableView.reloadData ;
    }];*/
    
    
   // Weather *weather = [[Weather alloc] init];
    
    
    
}

//WeatherRadar *myRadar = [[WeatherRadar alloc] getWeeklyWeather:22.719568 longitude:75.857727 completionBlock: nil];




- (IBAction)changeCityButtonAction:(UIButton *)sender {
    LocationManager = [[CLLocationManager alloc] init];
    LocationManager.delegate = self;
    LocationManager.distanceFilter = kCLDistanceFilterNone;
    LocationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;

    if ([[[UIDevice currentDevice]systemVersion ] floatValue]>=8.0) {
    [LocationManager  requestAlwaysAuthorization];
    }
    [LocationManager startUpdatingLocation];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Lat&Long"
                                 message:@"Latitude & Longitude Updated"
                                 preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* yesButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
       
    }];
  
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"%f", LocationManager.location.coordinate.latitude);
    NSLog(@"%f", LocationManager.location.coordinate.longitude);
    
    NSNumber *myDoubleLat = [NSNumber numberWithDouble:LocationManager.location.coordinate.latitude];
    [myDoubleLat stringValue];
    NSNumber *myDoubleLong = [NSNumber numberWithDouble:LocationManager.location.coordinate.longitude];
    [myDoubleLong stringValue];
    NSString *result = [[myDoubleLong stringValue] stringByAppendingFormat:@", %@", [myDoubleLat stringValue]];
    _cityNameLabel.text = result;
    
    
    WeatherRadar *weatherService = [[WeatherRadar alloc] init]; // Create an instance

    [weatherService getWeeklyWeather:[myDoubleLat floatValue]
                           longitude:[myDoubleLong floatValue]
                     completionBlock:^(NSArray *weeklyWeather) {
        // Handle the weekly weather data here
        NSLog(@"Received weekly weather data: %@", weeklyWeather);
        _weatherArray = weeklyWeather ;
        NSLog(@"Count:%lu",_weatherArray.count) ;
        _weatherListTableView.reloadData ;
    }];
   
    [LocationManager stopUpdatingLocation];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _weatherArray.count ;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
    myCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Iterate through the weeklyWeather array
    Weather *weatherDay = _weatherArray[indexPath.row];
    
    NSString *temperatureMinString = [NSString stringWithFormat:@"%d", weatherDay.temperatureMin];
    NSString *temperatureMaxString = [NSString stringWithFormat:@"%d", weatherDay.temperatureMax];
    cell.maximumTempLbl.text = [@"Max Temp = " stringByAppendingFormat:@"%@", temperatureMaxString];
    cell.minimumTempLbl.text = [@"Min Temp = " stringByAppendingFormat:@"%@", temperatureMinString];
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Weather *weatherDay = _weatherArray[indexPath.row];
    DescriptionViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DescriptionViewController"];
    vc.speed = weatherDay.windSpeed ;
    vc.humidity = weatherDay.humidity;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
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
