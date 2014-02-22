
//
//  BusBusViewController.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "BusBusViewController.h"
#import "Bus.h"
#import <MapKit/MapKit.h>

@interface BusBusViewController ()

@property (strong, nonatomic) BusListTable *busListController;

@end

@implementation BusBusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.busListController = [[BusListTable alloc] init];
    [self.busListTable setDelegate:self.busListController];
    [self.busListTable setDataSource:self.busListController];


    NSDictionary *busData = [self.convertDummyJSONData objectForKey:@"RESULTS"];
    NSLog(@"busData: %@", busData);
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];

    for (NSDictionary *busDictionary in busData) {

        NSString *route = [busDictionary objectForKey:@"route"];
        NSString *latitude = [busDictionary objectForKey:@"latitude"];
        NSString *longitude = [busDictionary objectForKey:@"longitude"];
        NSString *address = [busDictionary objectForKey:@"address"];

        Bus *bus = [[Bus alloc] initWithRoute:route lat:latitude lng:longitude nextStop:address];
        [tempArray addObject:bus];

        self.buses = [[NSArray alloc] initWithArray:tempArray];

    }


    // This needs to be refactored. Need to pass bus model to BusListTable
    self.busListController.busList = self.buses;

    [self setDummyLocationToBoston];
}

- (NSDictionary *)convertDummyJSONData
{

    NSString *stringOfJSON = @"{\"buses\":[{\"id\":0,\"route\":\"170\",\"address\":\"Tehama Street\",\"registered\":\"2006-04-20T11:40:17 +04:00\",\"latitude\":-76.20275,\"longitude\":81.86816},{\"id\":1,\"route\":\"184\",\"address\":\"Himrod Street\",\"registered\":\"2012-06-29T08:45:47 +04:00\",\"latitude\":13.414175,\"longitude\":-87.078125},{\"id\":2,\"route\":\"147\",\"address\":\"Ocean Court\",\"registered\":\"2012-07-23T16:23:04 +04:00\",\"latitude\":-83.58949,\"longitude\":92.87973},{\"id\":3,\"route\":\"187\",\"address\":\"Schenck Street\",\"registered\":\"1990-03-10T16:45:38 +05:00\",\"latitude\":-13.300719,\"longitude\":-115.40237},{\"id\":4,\"route\":\"181\",\"address\":\"Beaumont Street\",\"registered\":\"2001-11-26T10:07:16 +05:00\",\"latitude\":23.546043,\"longitude\":81.48651},{\"id\":5,\"route\":\"175\",\"address\":\"Schweikerts Walk\",\"registered\":\"2010-12-07T02:09:31 +05:00\",\"latitude\":-47.799652,\"longitude\":-146.06697},{\"id\":6,\"route\":\"136\",\"address\":\"Dunne Place\",\"registered\":\"2011-05-15T17:26:23 +04:00\",\"latitude\":-11.121938,\"longitude\":4.552646},{\"id\":7,\"route\":\"149\",\"address\":\"Onderdonk Avenue\",\"registered\":\"1996-12-16T05:55:15 +05:00\",\"latitude\":83.2037,\"longitude\":-177.65755},{\"id\":8,\"route\":\"104\",\"address\":\"Jerome Avenue\",\"registered\":\"2001-07-29T13:28:08 +04:00\",\"latitude\":80.375496,\"longitude\":132.18298},{\"id\":9,\"route\":\"110\",\"address\":\"Dwight Street\",\"registered\":\"2012-01-12T15:25:48 +05:00\",\"latitude\":-1.317282,\"longitude\":151.51135}]}";

    NSData *data = [stringOfJSON dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    return dictionary;
}

- (void)setDummyLocationToBoston
{
    CLLocationCoordinate2D boston = CLLocationCoordinate2DMake(42.36, -71.06);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(boston, 1000, 1000);
    [self.mapView setRegion:region animated:NO];
    boston.latitude -= self.mapView.region.span.latitudeDelta * 0.3;
    [self.mapView setCenterCoordinate:boston];
}

@end
