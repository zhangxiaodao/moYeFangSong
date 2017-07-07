//
//  CZBtnView.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/6.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "CZBtnView.h"

@interface CZBtnView ()
@property (nonatomic , strong) UIButton *button;
@end

@implementation CZBtnView

- (CZBtnView *)initCZBtnViewOf:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor addTarget:(nullable id)target action:(nonnull SEL)action {
    
    self = [super init];
    
    if (self) {
        
        self.layer.shadowColor = kMainColor.CGColor;
        self.layer.shadowOffset = CGSizeMake(3, 5);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 3;// 阴影扩散的范围控制
        
        
        UIButton *button = [UIButton cz_textButton:title fontSize:fontSize normalColor:highlightedColor highlightedColor:[UIColor whiteColor]];
        [button setTitle:title forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:normalColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:highlightedColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = kBtnCorHeight;
        button.layer.borderWidth = 2;
        button.layer.borderColor = highlightedColor.CGColor;
        [button sizeToFit];
        
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        self.button = button;
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.button setTitle:_title forState:UIControlStateNormal];
}

@end
