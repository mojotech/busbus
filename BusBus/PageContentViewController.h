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
@property (strong, nonatomic) IBOutlet UILabel *stop;

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *busStop;

@end
