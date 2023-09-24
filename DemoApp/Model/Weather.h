//
//  Weather.h
//  DemoApp
//
//  Created by Kumar Anand on 23/09/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Weather : NSObject

/// the date this weather is relevant to
@property (nonatomic, strong) NSDate *dateOfForecast;

/// the general weather status:
/// clouds, rain, thunderstorm, snow, etc...
@property (nonatomic, strong) NSString* status;

/// the ID corresponding to general weather status
@property (nonatomic) int statusID;

/// a more descriptive weather condition:
/// light rain, heavy snow, etc...
@property (nonatomic, strong) NSString* condition;

/// min/max temp in farenheit
@property (nonatomic) int temperatureMin;
@property (nonatomic) int temperatureMax;
@property (nonatomic) int humidity;
@property (nonatomic) float windSpeed;

- (instancetype)initWithDictionary:
(NSDictionary *) dictionary
isCurrentWeather:(BOOL)isCurrentWeather;

@end

NS_ASSUME_NONNULL_END
