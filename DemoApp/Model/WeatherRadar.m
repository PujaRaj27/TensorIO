//
//  WeatherRadar.m
//  DemoApp
//
//  Created by Kumar Anand on 23/09/23.
//

#import "WeatherRadar.h"
#import <AFNetworking/AFNetworking.h>
#import "Weather.h"


@implementation WeatherRadar

- (void)fetchWeatherFromProvider:(NSString*)URL completionBlock:
  (void (^)(NSDictionary *))completionBlock {

    AFHTTPRequestOperationManager *manager =
    [AFHTTPRequestOperationManager manager];

    [manager GET:URL parameters:nil success:
    ^(AFHTTPRequestOperation* operation, id responseObject) {
        if (responseObject) {
            completionBlock(responseObject);
        } else {
            // handle no results
        }
    } failure:^(AFHTTPRequestOperation*
    operation, NSError *error) {
        // handle error
    }
    ];
}



- (void)getWeeklyWeather:(float)latitude longitude:(float)longitude
completionBlock:(void (^)(NSArray *))completionBlock {



    NSString *urlString = [NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/forecast?"
                          "lat=%f&lon=%f&cnt=7&appid=d40c73b580c9c4d614814d116865e800", latitude, longitude];
//https://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&cnt=7&appid=d40c73b580c9c4d614814d116865e800

    // Create a character set with characters that should not be percent-encoded
    NSCharacterSet *allowedCharacterSet = [NSCharacterSet URLQueryAllowedCharacterSet];

    // Encode the URL string
    NSString *encodedURLString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];

    // Create an NSURL object from the encoded URL string
    NSURL *url = [NSURL URLWithString:encodedURLString];
    

    // Convert the NSURL object back to an NSString
    NSString *urlStringFromURL = [url absoluteString];
    
    // call the fetch function from Listing 4
    [self fetchWeatherFromProvider:urlStringFromURL completionBlock:
      ^(NSDictionary * weatherData) {
        // create an array of weather objects (one for each day)
        // initialize them using the function from listing 7
        // and return the results to the calling controller
        NSMutableArray *weeklyWeather = [[NSMutableArray alloc] init];
        for(NSDictionary* weather in weatherData[@"list"]) {
        // pass false since the weather is a future forecast
        // this lets the init function know which format of
        // data to parse
        
        Weather* day = [[Weather alloc]
        initWithDictionary:weather isCurrentWeather:FALSE];
        [weeklyWeather addObject:day];
        }
       
        completionBlock(weeklyWeather);
       
        }
        ];
    }


//- (void)getCurrentWeather:(float)latitude longitude:(float)longitude
  // completionBlock:(void (^)Weather *))completionBlock {
    
- (void)getCurrentWeather:(float)latitude
                                longitude:(float)longitude
completionBlock:(void (^)(Weather * _Nullable))completionBlock {
        // formulate the url to query the api to get current weather
                         
NSString *url = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?"
                                               "units=imperial&cnt=7&lat=%f&lon=%f", latitude, longitude];

        // escape the url to avoid any potential errors
        url = [url stringByAddingPercentEscapesUsingEncoding:
        NSUTF8StringEncoding];

        // call the fetch function from Listing 4
        [self fetchWeatherFromProvider:url completionBlock:
          ^(NSDictionary * weatherData) {
            // create an weather object by initializing it with
            // data from the API using the init func from Listing 7
            completionBlock([[Weather alloc]
            initWithDictionary:weatherData isCurrentWeather:TRUE]);
        }];
}



@end
