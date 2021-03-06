//
//  MYUserInfoBaseViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/6.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYUserInfoBaseViewController.h"

@interface MYUserInfoBaseViewController ()

@end

@implementation MYUserInfoBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kCOLOR(249, 251, 252);
    
    MYUserInfoModel *model = [[MYUserInfoModel alloc]init];
    self.model = model;
    self.model.sex = @"女";
    self.model.birthday = @"1991-1-1";
    self.model.height = @"170cm";
    self.model.weight = @"50kg";
    self.model.phoneNumber = @"请输入手机号";
    
    _rightBarItem = [UIBarButtonItem itemWithTarget:self action:@selector(delegateAtcion) image:@"nav_addSuucess_helighted" highImage:@"nav_addSuucess"];
    
    UILabel *titlelabel = [UILabel cz_labelWithText:@"" fontSize:k15 color:kCOLOR(132, 145, 150) textAligment:NSTextAlignmentCenter superView:self.view];
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(kScreenW / 15);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 15));
    }];
    self.titlelabel = titlelabel;
    
    UIView *centerView = [[UIView alloc]init];
    [self.view addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(titlelabel.mas_bottom).offset(kScreenW / 15);
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 1.6));
    }];
    self.centerView = centerView;
    
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(centerView.mas_bottom).offset(kScreenW / 18);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 6.25, kScreenW / 6.8));
    }];
    self.bottomView = bottomView;
    
    CZBtnView *backbtn = [[CZBtnView alloc]initCZBtnViewOf:@"上一步" fontSize:k20 normalColor:kWhiteColor highlightedColor:kMainColor addTarget:self action:@selector(backbtnAtcion)];
    [self.bottomView addSubview:backbtn];
    [backbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView.mas_centerY);
        make.left.mas_equalTo(self.bottomView.mas_left);
        make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW / 6.25 - kScreenW / 12) / 2, kScreenW / 7));
    }];
    self.backbtn = backbtn;
    
    CZBtnView *nextbtn = [[CZBtnView alloc]initCZBtnViewOf:@"下一步" fontSize:k20 normalColor:kWhiteColor highlightedColor:kMainColor addTarget:self action:@selector(nextbtnAtcion)];
    [self.bottomView addSubview:nextbtn];
    [nextbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView.mas_centerY);
        make.right.mas_equalTo(self.bottomView.mas_right);
        make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW / 6.25 - kScreenW / 12) / 2, kScreenW / 7));
    }];
    self.nextbtn = nextbtn;
    
    backbtn.hidden = YES;
    nextbtn.hidden = YES;
    
    
    if ([self.bottomViewHidden isEqualToString:@"YES"]) {
        bottomView.hidden = YES;
        self.navigationItem.rightBarButtonItem = _rightBarItem;
    }
}

- (void)delegateAtcion {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendInfoToSuperVC:)]) {
        [self.view endEditing:YES];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        [self.delegate sendInfoToSuperVC:self.model];
    }
}

- (void)backbtnAtcion {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextbtnAtcion {
    
}

- (void)setBottomViewHidden:(NSString *)bottomViewHidden {
    _bottomViewHidden = bottomViewHidden;
}

@end
