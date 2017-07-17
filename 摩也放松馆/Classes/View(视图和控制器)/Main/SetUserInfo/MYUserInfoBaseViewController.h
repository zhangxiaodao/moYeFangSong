//
//  MYUserInfoBaseViewController.h
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/6.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MYUserInfoBaseDelegate <NSObject>

- (void)sendInfoToSuperVC:(MYUserInfoModel *)model;

@end

@interface MYUserInfoBaseViewController : UIViewController
@property (nonatomic , strong) UILabel *titlelabel;
@property (nonatomic , strong) UIView *centerView;
@property (nonatomic , strong) UIView *bottomView;

@property (nonatomic , strong) UIBarButtonItem *rightBarItem;
@property (nonatomic , strong) CZBtnView *backbtn;
@property (nonatomic , strong) CZBtnView *nextbtn;
@property (nonatomic , strong) MYUserInfoModel *model;

@property (nonatomic , assign) id<MYUserInfoBaseDelegate> delegate;

@property (nonatomic , copy) NSString *bottomViewHidden;

- (void)nextbtnAtcion;

- (void)delegateAtcion;
@end
