//
//  MainViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MainViewController.h"
#import "LaunchView.h"
#import "MYNavViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *firstUse = [kStanderDefault objectForKey:@"FirstUse"];
    
    if (![firstUse isEqualToString:@"NO"]) {
        LaunchView *launchView = [LaunchView createLaunchView];
        [self.view addSubview:launchView];
    }
    
    NSArray *array = @[
  @{@"clsName": @"MYOperationViewController" ,@"title":@"放松管" , @"imageName":@"" , @"storyboard":@"MYOperationViewController"} ,
  @{@"clsName": @"MYAddServiceViewController" ,@"title":@"设备" , @"imageName":@""} ,
  @{@"clsName": @"MYMineInfoViewController" ,@"title":@"其他" , @"imageName":@""}];
    NSMutableArray *arrayVC = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        [arrayVC addObject:[self controllers:dict]];
    }
    
    self.viewControllers = arrayVC;
    self.tabBar.tintColor = kMainColor;
}

- (UINavigationController *)controllers:(NSDictionary *)dict {
    NSString *title = dict[@"title"];
    NSString *imageName = dict[@"imageName"];
//    NSString *storyboard = dict[@"storyboard"];
    NSString *clsName = dict[@"clsName"];
    Class cls = NSClassFromString(clsName);
    
    
    UIViewController *vc = [[cls alloc]init];
    
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    MYNavViewController *nav = [[MYNavViewController alloc]initWithRootViewController:vc];
    
    return nav;
}

@end
