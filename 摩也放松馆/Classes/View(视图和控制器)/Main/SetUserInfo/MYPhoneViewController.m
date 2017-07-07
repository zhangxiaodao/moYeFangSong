//
//  MYPhoneViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/6.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYPhoneViewController.h"
#import "MYPhoneView.h"
#import "MainViewController.h"
@interface MYPhoneViewController ()

@end

@implementation MYPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)setupUI {
    [super setupUI];
    
    self.titlelabel.text = @"请输入您的手机号";
    
    self.backbtn.hidden = NO;
    self.nextbtn.hidden = NO;
    
    self.nextbtn.title = @"完成";
    
    MYPhoneView *phoneView = [MYPhoneView cz_PhoneViewFrame:CGRectMake(0, 0, kScreenW / 1.4, kScreenW / 8.3) leftImage:[UIImage imageNamed:@"phone"] andPlaceholder:@"请输入您的手机号码"];
    [self.centerView addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.centerView.mas_centerX);
        make.top.mas_equalTo(self.centerView.mas_top).offset(kScreenW / 3.2);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 1.4, kScreenW / 8.3));
    }];
    phoneView.backgroundColor = kWhiteColor;
}

- (void)nextbtnAtcion {
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    kWindowRoot = mainVC;
}

@end

