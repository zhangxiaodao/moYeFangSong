//
//  MYFeedBackInputView.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/18.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYFeedBackInputView.h"

@implementation MYFeedBackInputView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = kWhiteColor;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        UITextField *textField = [[UITextField alloc] init];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(kScreenW / 37.5);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(kScreenW / 1.34, kScreenW / 9.375));
        }];
        self.textField = textField;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(textField.mas_right).offset(kScreenW / 37.5);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(kScreenW / 5.76, kScreenW / 9.375));
        }];
        [button setTitle:@"发送" forState:UIControlStateNormal];
        [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor grayColor]];
        button.layer.cornerRadius = 5;
        self.button = button;
        
    }
    return self;
}

@end
