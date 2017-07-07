//
//  MYPhoneView.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/7.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYPhoneView.h"
#import "UITextField+Custom.h"

@implementation MYPhoneView

- (instancetype)initFrame:(CGRect)frame leftImage:(UIImage *)image andPlaceholder:(NSString *)placeholder {
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

+ (MYPhoneView *)cz_PhoneViewFrame:(CGRect)frame leftImage:(UIImage *)image andPlaceholder:(NSString *)placeholder {
    MYPhoneView *view = [[MYPhoneView alloc]initFrame:frame leftImage:image andPlaceholder:placeholder];
    view.layer.shadowColor = kMainColor.CGColor;
    view.layer.shadowOffset = CGSizeMake(3, 5);
    view.layer.shadowOpacity = 0.3;
    view.layer.shadowRadius = 3;// 阴影扩散的范围控制

    UIImageView *leftIV = [[UIImageView alloc]initWithImage:image];
    [view addSubview:leftIV];
    [leftIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(view.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(view.height * 3 / 6, view.height * 3 / 6));
    }];
    
    UITextField *textfiled = [UITextField creatTextfiledWithPlaceHolder:placeholder andSuperView:view];
    [textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(leftIV.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(view.width * 2 / 3, view.height * 5 / 6));
    }];
    
    return view;
}

@end
