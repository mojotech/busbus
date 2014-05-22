//
//  BOClient.m
//  BusBus
//
//  Created by Ryan on 3/31/14.
//
//

#import "BSBBus.h"
#import "BOClient.h"

static NSString * const BSBServiceHost = @"transit.nodejitsu.com";
static NSString * const BSBServiceBusFeedPath = @"/api/feed/near";
static NSString * const BSBServiceStopPath = @"/api/near-stops";

@interface BOClient ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation BOClient

- (instancetype)init
{
    self = [super init];
    if(self == nil) {
        return nil;
    }
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config];
    
    return self;
}

- (NSURLComponents *)componentsForBasicServiceCall
{
    NSURLComponents *requestURLComponents = [NSURLComponents new];
    requestURLComponents.scheme = @"http";
    requestURLComponents.host = BSBServiceHost;
    return requestURLComponents;
}

- (void)runDataTaskWithURL:(NSURL *)url completion:(void(^)(id JSONResult))completion failure:(void(^)(NSError *))failure
{
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                     
                                                     if (error) {
                                                         NSLog(@"%@", error);
                                                         if (failure){
                                                             failure(error);
                                                         }
                                                         return;
                                                     }
                                                     
                                                     NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                     
                                                     id JSONResults = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                     
                                                     if (error) {
                                                         NSLog(@"JSON error: %@", error);
                                                         if (failure) {
                                                             failure(error);
                                                         }
                                                         return;
                                                     }
                                                     
                                                     if (completion) {
                                                         completion(JSONResults);
                                                     }
                                                 }];
    [dataTask resume];
}

- (NSString *)servicePathForEntity:(BSBServiceEntity)entity
{
    static NSDictionary *entityPathMap;
    entityPathMap = @{@(BSBServiceEntityBus) : BSBServiceBusFeedPath,
                      @(BSBServiceEntityBusStop) : BSBServiceStopPath
                      };
    return entityPathMap[@(entity)];
}

- (void)fetchEntity:(BSBServiceEntity)entity
       nearLocation:(CLLocationCoordinate2D)coordinate
             radius:(CLLocationDistance)distance
         completion:(void(^)(NSArray *))completion
            failure:(void(^)(NSError *))failure
{
    NSURLComponents *requestURLComponents = [self componentsForBasicServiceCall];
    requestURLComponents.path = [self servicePathForEntity:entity];
    requestURLComponents.query = [NSString stringWithFormat:@"latitude=%f&longitude=%f&radius=%f",coordinate.latitude, coordinate.longitude, distance];
    
    [self runDataTaskWithURL:requestURLComponents.URL
                  completion:^(id JSONResult) {
                      if (![JSONResult isKindOfClass:[NSArray class]]) {
                          if (failure) { failure(nil); }
                      }
                      
                      if (completion) {
                          completion(JSONResult);
                      }
                  } failure:failure];
}

@end
