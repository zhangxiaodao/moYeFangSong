//
//  MYSexViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/6.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYSexViewController.h"
#import "MYBirthdayViewController.h"

@interface MYSexViewController ()
@property (nonatomic , strong) UIImageView *manIv;
@property (nonatomic , strong) UIImageView *womanIv;
@end

@implementation MYSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];
    
}

- (void)setupUI {
    
    [super setupUI];
    
    self.titlelabel.text = @"请选择您的性别";
    
    UIImageView *womanIv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"woman_selected"]];
    [self.centerView addSubview:womanIv];
    [womanIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.centerView.mas_centerX);
        make.top.mas_equalTo(self.centerView.mas_top).offset(kScreenW / 9.375 - kScreenW / 25);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2.6, kScreenW / 2.6));
    }];
    
    UIImageView *manIv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"man"]];
    [self.centerView addSubview:manIv];
    [manIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(womanIv.mas_bottom).offset(kScreenW / 7.8);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2.6, kScreenW / 2.6));
    }];
    
    womanIv.userInteractionEnabled = YES;
    manIv.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *womantap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeImage:)];
    [womanIv addGestureRecognizer:womantap];
    
    UITapGestureRecognizer *mantap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeImage:)];
    [manIv addGestureRecognizer:mantap];

    self.manIv = manIv;
    self.womanIv = womanIv;
    
    CZBtnView *nextbtn = [[CZBtnView alloc]initCZBtnViewOf:@"下一步" fontSize:k20 normalColor:kWhiteColor highlightedColor:kMainColor addTarget:self action:@selector(nextbtnAtcion)];
    [self.bottomView addSubview:nextbtn];
    [nextbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomView.mas_centerX);
        make.centerY.mas_equalTo(self.bottomView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 6.25, kScreenW / 7));
    }];
    
    
}

- (void)changeImage:(UITapGestureRecognizer *)tap {
    
    self.womanIv.image = [UIImage imageNamed:@"woman"];
    self.manIv.image = [UIImage imageNamed:@"man"];
    if ([tap.view isEqual:self.womanIv]) {
        self.womanIv.image = [UIImage imageNamed:@"woman_selected"];
    } else {
        self.manIv.image = [UIImage imageNamed:@"man_selected"];
    }
}

- (void)nextbtnAtcion {
    MYBirthdayViewController *birthdayVC = [[MYBirthdayViewController alloc]init];
    birthdayVC.navigationItem.title = @"完善个人信息(2/5)";
    [self.navigationController pushViewController:birthdayVC animated:YES];
}

@end
