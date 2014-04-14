//
//  AppDelegate.m
//  HttpRequestDownloadDemo
//
//  Created by MagicLGD on 14-3-24.
//  Copyright (c) 2014年 123. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DownListViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *) application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    DownListViewController * Firstcontroller = [[[DownListViewController alloc]initWithNibName:@"DownListViewController" bundle:nil]autorelease];
    Firstcontroller.title = @"下载目录";
    
    
    ViewController*secondController = [[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil]autorelease];
    secondController.title = @"下载队列";
    
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.delegate = self;
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:Firstcontroller, secondController, nil];
    
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
