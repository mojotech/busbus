//
//  busbusViewController.h
//  busbus
//
//  Created by Sam Saccone on 9/19/13.
//  Copyright (c) 2013 Sam Saccone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface busbusViewController : UIViewController <MKMapViewDelegate>
{
    IBOutlet MKMapView *map;
}
@end
