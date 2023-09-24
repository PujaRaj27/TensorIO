//
//  WeatherRadar.h
//  DemoApp
//
//  Created by Kumar Anand on 23/09/23.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherRadar : NSObject

- (void)getWeeklyWeather:(float)latitude longitude:(float)longitude
   completionBlock:(void (^)(NSArray *))completionBlock;

- (void)getCurrentWeather:(float)latitude longitude:(float)longitude
   completionBlock:(void (^)(Weather *))completionBlock;
@end

NS_ASSUME_NONNULL_END
