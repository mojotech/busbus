//
//  AppDelegate.m
//  BusBus
//
//  Created by Ryan on 2/12/14.
//
//

#import "BSBAppDelegate.h"
#import "BusBusViewController.h"

@implementation BSBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[BusBusViewController new]];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
