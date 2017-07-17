//
//  MYQuestionHeaderView.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/17.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYQuestionHeaderView.h"
#import "MYCalculateHeight.h"


@implementation MYQuestionHeaderView

- (instancetype)initWithFrame:(CGRect)frame withText:(NSString *)text {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = kWhiteColor;
        
        UIView *circleView = [[UIView alloc]init];
        [self addSubview:circleView];
        circleView.backgroundColor = kMainColor;
        [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).offset(kScreenW / 25);
            make.size.mas_equalTo(CGSizeMake(5, 5));
        }];
        circleView.layer.cornerRadius = 2.5;
        
        UILabel *textLabel = [UILabel cz_labelWithText:text fontSize:k15 color:kCOLOR(134, 141, 155) textAligment:NSTextAlignmentLeft superView:self];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(circleView.mas_right).offset(kScreenW / 37.5);
            make.size.mas_equalTo(CGSizeMake(kScreenW / 1.25, frame.size.height - 1));
        }];
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav_addSuucess"]];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(textLabel.mas_right).offset(kScreenW / 37.5);
            make.size.mas_equalTo(CGSizeMake(kScreenW / 15, kScreenW / 15));
        }];
        self.imageView = imageView;
        
        UIView *bottomView = [[UIView alloc]init];
        [self addSubview:bottomView];
        bottomView.backgroundColor = kCOLOR(245, 252, 255);
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom);
            make.left.mas_equalTo(circleView.mas_left);
            make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
        }];
        
    }
    return self;
}


@end
