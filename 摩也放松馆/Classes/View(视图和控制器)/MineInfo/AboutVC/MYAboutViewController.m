//
//  MYAboutViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/17.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYAboutViewController.h"
#import "MYAboutViewHeaderView.h"

@interface MYAboutViewController ()

@end

@implementation MYAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    
}

- (void)setupUI {
    MYAboutViewHeaderView *view = [[MYAboutViewHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    [self.view addSubview:view];
    view.version = @"1.0.0";
}
@end
