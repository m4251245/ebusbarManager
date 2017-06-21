//
//  AppDelegate.m
//  ebusbarManager
//
//  Created by 刘必红 on 2017/5/24.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UINavigationController *nav = [[NSClassFromString(@"BSBNavigationController") alloc] initWithRootViewController:[[NSClassFromString(@"BSBLoginViewController") alloc] init]];
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
    [self checkNetworkStatus];
    
    return YES;
}

- (void)checkNetworkStatus
{
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    
    [afNetworkReachabilityManager startMonitoring];  //开启网络监视器；
    
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSString *text = nil;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                
            case AFNetworkReachabilityStatusNotReachable:{
                text = @"网络异常！";
                [MBProgressHUD showError:text];
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                text = @"网络通过WIFI连接！";
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                text = @"网络通过WWAN连接！";
                break;
            }
            default:
                break;
        }
        
        NSLog(@"%@", AFStringFromNetworkReachabilityStatus(status));
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
