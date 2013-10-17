//
//  PFAppDelegate.m
//  Stripe
//
//  Created by Andrew Wang on 2/25/13.
//

#import "PFProductsViewController.h"
#import "PFStoreAppDelegate.h"
#import <Turnpike/Turnpike.h>

@implementation PFStoreAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    [Parse setApplicationId:infoDictionary[@"PARSE_APPLICATION_ID"] clientKey:infoDictionary[@"PARSE_CLIENT_KEY"]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UINavigationController *rootController = [[UINavigationController alloc] initWithRootViewController:[[PFProductsViewController alloc] init]];
    rootController.navigationBar.hidden = YES;
    self.window.rootViewController = rootController;
    
    
    // Turnpike:
    [Turnpike mapRoute:@"hello" ToDestination:^(TPRouteRequest *request) {
        NSLog(@"Hello World!");
    }];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [Turnpike resolveURL:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [Turnpike resolveURL:url];
    return YES;
}
                                                                                                                                                 
                                                                                                                                                 
                                                                                                                                                 
                                                                                                                                                 
                                                                                                                                                 
                                                                                                                                                 
@end
