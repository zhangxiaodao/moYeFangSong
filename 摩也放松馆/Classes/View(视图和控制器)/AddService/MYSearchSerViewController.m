//
//  MYSearchSerViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/10.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYSearchSerViewController.h"

@interface MYSearchSerViewController ()
@property (nonatomic , strong) NSArray *imageNameAry;
@end

@implementation MYSearchSerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupNav];
    
    [self setupUI];
    
}

- (void)setupNav {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(addSuccess) image:@"nav_addSuucess" highImage:@"nav_addSuucess_helighted"];
    
}

- (void)setupUI {
    UIImageView *centerIV = [[UIImageView alloc]init];
    [self.view addSubview:centerIV];
    [centerIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-kScreenW / 18.75);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 2));
    }];
    centerIV.animationImages = self.imageNameAry;
    centerIV.animationDuration = 2.0;
    centerIV.animationRepeatCount = MAXFLOAT;
    [centerIV startAnimating];
    
    UIImageView *animationIv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"animationIv"]];
    [self.view addSubview:animationIv];
    [animationIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(centerIV.mas_centerX);
        make.centerY.mas_equalTo(centerIV.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2 * 0.6 + 10, kScreenW / 2 * 0.6 + 10));
    }];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 3;
    [animationIv.layer addAnimation:animation forKey:nil];
    
    
    UILabel *alertLabel = [UILabel cz_labelWithText:@"搜索设备..." fontSize:k15 color:kWhiteColor textAligment:NSTextAlignmentCenter superView:self.view];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(centerIV.mas_centerX);
        make.centerY.mas_equalTo(centerIV.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 25));
    }];
}

- (void)addSuccess {
    NSLog(@"设备添加成功");
}

- (NSArray *)imageNameAry {
    if (!_imageNameAry) {
        _imageNameAry = [NSArray arrayWithObjects: [UIImage imageNamed:@"searchSer_center1"] , [UIImage imageNamed:@"searchSer_center2"] , [UIImage imageNamed:@"searchSer_center3"] , [UIImage imageNamed:@"searchSer_center4"] , [UIImage imageNamed:@"searchSer_center5"] , nil];
    }
    return _imageNameAry;
}

@end
