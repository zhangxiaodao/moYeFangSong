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
#import "MYSexViewController.h"

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
                       @{@"clsName": @"MYOperationViewController" ,@"title":@"放松管" , @"imageName":@"fangSongGuan"} ,
                       @{@"clsName": @"MYAddServiceViewController" ,@"title":@"设备" , @"imageName":@"sheBei"} ,
                       @{@"clsName": @"MYMineInfoViewController" ,@"title":@"其他" , @"imageName":@"qiTa"}];
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
    NSString *clsName = dict[@"clsName"];
    Class cls = NSClassFromString(clsName);
    
    UIViewController *vc = nil;
    if ([clsName isEqualToString:@"MYOperationViewController"]) {
        vc = [[UIStoryboard storyboardWithName:@"MYOperationViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"MYOperationViewController"];
    } else {
        vc = [[cls alloc]init];
    }
    
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    MYNavViewController *nav = [[MYNavViewController alloc]initWithRootViewController:vc];
    
    return nav;
}

@end
