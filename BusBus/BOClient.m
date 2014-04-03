//
//  BOClient.m
//  BusBus
//
//  Created by Ryan on 3/31/14.
//
//

#import "Bus.h"
#import "BOClient.h"

@interface BOClient ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation BOClient

- (id)init
{
    if(self = [super init])
    {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    
    return self;
}

- (RACSignal *)fetchJSONFromURL:(NSURL *)url
{
    NSLog(@"Fetching url: %@", url.absoluteString);

    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

            if(!error) {
                NSError *jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];

                if(!jsonError) {
                    [subscriber sendNext:json];
                } else {
                    [subscriber sendError:jsonError];
                }
            } else {
                [subscriber sendNext:error];
            }
            
            [subscriber sendCompleted];
        }];

        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
        
    }] doError:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (RACSignal *)fetchBusLocationsNearUser: (CLLocationCoordinate2D)coordinate
{
    NSString *urlString = [NSString stringWithFormat:@"URL_HERE"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        return [MTLJSONAdapter modelOfClass:[Bus class]
                            fromJSONDictionary:json
                            error:nil];
    }];
}

@end
