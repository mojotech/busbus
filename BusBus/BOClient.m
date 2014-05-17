//
//  BOClient.m
//  BusBus
//
//  Created by Ryan on 3/31/14.
//
//

#import "BSBBus.h"
#import "BOClient.h"

@interface BOClient ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation BOClient

- (instancetype)init
{
    if(self == nil) {
        return nil;
    }
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config];
    
    return self;
}

- (void)fetchBusLocationsNearUser: (CLLocationCoordinate2D)coordinate completion:(void(^)(NSArray *))completion failure:(void(^)(NSError *))failure
{
    NSString *requestString = [NSString stringWithFormat:@"http://transit.nodejitsu.com/api/feed/near?latitude=%f&longitude=%f&radius=800",coordinate.latitude, coordinate.longitude];
    
    NSURL *url = [NSURL URLWithString:requestString];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                     
                                                     if (error) {
                                                         NSLog(@"%@", error);
                                                         if (failure){
                                                             failure(error);
                                                         }
                                                         return;
                                                     }
                                                     
                                                     NSArray *locations = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                     
                                                     if (error) {
                                                         NSLog(@"JSON error: %@", error);
                                                         if (failure) {
                                                             failure(error);
                                                         }
                                                         return;
                                                     }
                                                     
                                                     if (![locations isKindOfClass:[NSArray class]]) {
                                                         if (failure) {
                                                             failure(nil);
                                                         }
                                                     }
                                                     
                                                     if (completion) {
                                                         completion(locations);
                                                     }
                                                     
                                                 }];
    [dataTask resume];
    
}

@end
