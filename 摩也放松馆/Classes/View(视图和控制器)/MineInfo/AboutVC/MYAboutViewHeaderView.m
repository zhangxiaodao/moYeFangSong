//
//  MYAboutViewHeaderView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/10.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYAboutViewHeaderView.h"

#define STOREAPPID @"1113948983"

@implementation MYAboutViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenW / 4));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top).offset(kScreenW / 8.3);
        }];
        imageView.layer.cornerRadius = 10;
        imageView.layer.masksToBounds = YES;
        
        UILabel *versionLabel = [UILabel cz_labelWithText:nil fontSize:k15 color:[UIColor lightGrayColor] textAligment:NSTextAlignmentCenter superView:self];
        [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenW / 20));
            make.top.mas_equalTo(imageView.mas_bottom).offset(kScreenW / 25);
            make.centerX.mas_equalTo(imageView.mas_centerX);
        }];
        
        CZBtnView *btnView = [[CZBtnView alloc]initCZBtnViewOf:@"应用评分" fontSize:k15 normalColor:kWhiteColor highlightedColor:kMainColor addTarget:self action:@selector(evaluateAtcion)];
        [self addSubview:btnView];
        [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 6.25, kScreenW / 7.5));
            make.top.mas_equalTo(versionLabel.mas_bottom).offset(kScreenW / 7.5);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
    }
    
    return self;

}

- (void)evaluateAtcion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)setVersion:(NSString *)version {
    _version = version;
    
    UILabel *label = [self.subviews objectAtIndex:1];
    label.text = [NSString stringWithFormat:@"V %@" , _version];
}

@end
