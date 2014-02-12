//
//  BusBusViewController.h
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BusBusViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
