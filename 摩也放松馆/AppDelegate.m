//
//  AppDelegate.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MYSexViewController.h"
#import "MYNavViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    NSString *setUserInfo = [kStanderDefault objectForKey:@"SetUserInfo"];
    if ([setUserInfo isEqualToString:@"YES"]) {
        MYSexViewController *sexVC = [[MYSexViewController alloc]init];
        MYNavViewController *nav = [[MYNavViewController alloc]initWithRootViewController:sexVC];
        sexVC.navigationItem.title = @"完善个人信息(1/5)";
        self.window.rootViewController = nav;
    } else {
        MainViewController *mainVC = [[MainViewController alloc]init];
        self.window.rootViewController = mainVC;
    }
    
    return YES;
}

@end
