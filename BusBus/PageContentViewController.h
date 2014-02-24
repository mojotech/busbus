//
//  PageContentViewController.h
//  BusBus
//
//  Created by Ryan on 2/24/14.
//
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label;
@property NSUInteger pageIndex;
@property NSString *titleText;

@end
