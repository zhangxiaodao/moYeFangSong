//
//  MainViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MainViewController.h"
#import "LaunchView.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LaunchView *launchView = [LaunchView createLaunchView];
    
    [self.view addSubview:launchView];
    
}

@end
