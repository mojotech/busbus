//
//  BusBusViewController.h
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BusListTable.h"
#import "Bus.h"

@interface BusBusViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UITableView *busListTable;

@property (nonatomic, strong) Bus *bus;

- (NSDictionary *)convertDummyJSONData;

@end
