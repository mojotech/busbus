//
//  BSBClient.m
//  BusBus
//
//  Created by Ryan on 3/31/14.
//

#import "BSBBus.h"
#import "BSBClient.h"

static NSString *const BSBServiceHost = @"10.0.1.9:8000";//@"transit.nodejitsu.com";
static NSString *const BSBServiceBusFeedPath = @"/api/feed/near";
static NSString *const BSBServiceStopPath = @"/api/near-stops";
static NSString *const BSBServiceAlertsPath = @"/api/alerts";

@interface BSBClient ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation BSBClient

- (instancetype)init
{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    return self;
}

- (NSURLComponents *)componentsForBasicServiceCall
{
    NSURLComponents *requestURLComponents = [NSURLComponents new];
    requestURLComponents.scheme = @"http";
    requestURLComponents.host = BSBServiceHost;
    return requestURLComponents;
}

- (void)runDataTaskWithURL:(NSURL *)url completion:(void (^)(id JSONResult))completion failure:(void (^)(NSError *))failure
{
    BOOL (^safeFail)(NSError *) = ^(NSError *error){
        if (error == nil) return NO;
        NSLog(@"Error: %@ in %@", error, NSStringFromSelector(_cmd));
        if (failure) failure(error);
        return YES;
    };
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                     
                                                     if (safeFail(error)) return;
                                                     
                                                     NSString *s = [[NSString alloc] initWithData:data
                                                                                         encoding:NSUTF8StringEncoding];
                                                     
                                                     id JSONResults = [NSJSONSerialization JSONObjectWithData:data
                                                                                                      options:kNilOptions
                                                                                                        error:&error];
                                                     if (safeFail(error)) {
                                                         NSLog(@"request: %@", url);
                                                         NSLog(@"Error in response :: %@", s);
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
                      @(BSBServiceEntityBusStop) : BSBServiceStopPath,
                      @(BSBServiceEntityAlerts) : BSBServiceAlertsPath,
    };
    return entityPathMap[@(entity)];
}

- (void)fetchEntity:(BSBServiceEntity)entity
         completion:(void (^)(NSArray *))completion
            failure:(void (^)(NSError *))failure
{
    [self fetchEntity:entity
         nearLocation:kCLLocationCoordinate2DInvalid
               radius:0
           completion:completion
              failure:failure];
}

- (void)fetchEntity:(BSBServiceEntity)entity
       nearLocation:(CLLocationCoordinate2D)coordinate
             radius:(CLLocationDistance)distance
         completion:(void (^)(NSArray *))completion
            failure:(void (^)(NSError *))failure
{
    NSURLComponents *requestURLComponents = [self componentsForBasicServiceCall];
    requestURLComponents.path = [self servicePathForEntity:entity];

    if (CLLocationCoordinate2DIsValid(coordinate)) {
        requestURLComponents.query = [NSString stringWithFormat:@"latitude=%f&longitude=%f&radius=%f",
                                                                coordinate.latitude, coordinate.longitude, distance];
    }

    [self runDataTaskWithURL:requestURLComponents.URL
                  completion:^(id JSONResult) {
                      if (![JSONResult isKindOfClass:[NSArray class]]) {
                          if (failure) {failure(nil);}
                      }

                      if (completion) {
                          completion(JSONResult);
                      }
                  } failure:failure];
}

@end
