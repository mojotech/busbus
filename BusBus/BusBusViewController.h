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

@interface BusBusViewController : UIViewController <MKMapViewDelegate>
{
    IBOutlet MKMapView *mapView;
    IBOutlet UITableView *busListTable;
}
@end
