//
//  MYUserInfoBaseViewController.h
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/6.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYUserInfoBaseViewController : UIViewController
@property (nonatomic , strong) UILabel *titlelabel;
@property (nonatomic , strong) UIView *centerView;
@property (nonatomic , strong) UIView *bottomView;
@property (nonatomic , strong) CZBtnView *backbtn;
@property (nonatomic , strong) CZBtnView *nextbtn;

- (void)setupUI;
- (void)nextbtnAtcion;
@end
