//
//  PFAppDelegate.m
//  URXShop
//
//  Created by David Lee on 10/17/13.
//

#import "AppDelegate.h"
#import "ProductsViewController.h"
#import "ProductViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:@"YourParseApplicationID"clientKey:@"YourParseClientAPIKey"];
    
    return YES;
}

// iOS >= 4.2
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return YES;
}

// iOS < 4.2
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return YES;
}

                                                                                                                                                 
@end
