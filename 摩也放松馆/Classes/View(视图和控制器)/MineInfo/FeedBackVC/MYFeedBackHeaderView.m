//
//  MYFeedBackHeaderView.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/19.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYFeedBackHeaderView.h"

@implementation MYFeedBackHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        UILabel *label = [UILabel cz_labelWithText:[self getNowTimeString] fontSize:k12 color:kCOLOR(207, 207, 208) textAligment:NSTextAlignmentCenter superView:self];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 3, frame.size.height));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        label.backgroundColor = kCOLOR(242, 242, 244);
        label.layer.cornerRadius = 8;
        label.layer.masksToBounds = YES;
    }
    return self;
}


- (NSString *)getNowTimeString {
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSString *nowTime = [dateFormatter stringFromDate:nowDate];
    return nowTime;
}


@end
