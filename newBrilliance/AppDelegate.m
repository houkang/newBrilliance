//
//  AppDelegate.m
//  newBrilliance
//
//  Created by 软件工程系01 on 2018/4/16.
//  Copyright © 2018年 软件工程系01. All rights reserved.
//

#import "AppDelegate.h"
#import "firstLaunchViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSString *lastRunKey = [defaults objectForKey:@"last_run_version_key"];
    if (!lastRunKey) {
        [defaults setObject:currentVersion forKey:@"last_run_version_key"];
        //上次运行版本为空，app为首次运行
        NSLog(@"上次运行版本为空，app为首次运行");
        
        firstLaunchViewController *firstLaunchVC = [[firstLaunchViewController alloc]init];
        NSString *path =[[NSBundle mainBundle]pathForResource:@"movie" ofType:@"mp4"];
        firstLaunchVC.movieURL = [NSURL fileURLWithPath:path];
        self.window.rootViewController = firstLaunchVC;
        
    }
    else if (![lastRunKey isEqualToString:currentVersion]) {
        [defaults setObject:currentVersion forKey:@"last_run_version_key"];
        //app更新了，版本号发生了变化
        NSLog(@"app更新了，版本号发生了变化");
        
    }else{
        NSLog(@"直接进入登录界面");
        
    }
    return YES;
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
