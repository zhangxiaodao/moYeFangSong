//
//  MYWorkTypeBtnView.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/11.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYWorkTypeBtnView.h"

@interface MYWorkTypeBtnView ()
@property (nonatomic , strong) NSArray *typeArray;

@end

@implementation MYWorkTypeBtnView

- (NSArray *)typeArray {
    if (!_typeArray) {
        _typeArray = [NSArray arrayWithObjects: @"揉", @"按", @"挤", @"抚", @"肘", @"锤", nil];
    }
    return _typeArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat btnW = (frame.size.width - kScreenW / 9.375) / self.typeArray.count;
        
        for (int i = 0; i < self.typeArray.count; i++) {
            UIButton *btn = [UIButton cz_textButton:self.typeArray[i] fontSize:k15 normalColor:kWhiteColor highlightedColor:kWhiteColor];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(btnW , frame.size.height));
                make.centerY.mas_equalTo(self.mas_centerY);
                make.left.mas_equalTo(self.mas_left).offset(kScreenW / 18.75 + i * btnW);
            }];
            btn.tag = i;
            [btn addTarget:self action:@selector(btnAtcion:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *selectedView = [[UIView alloc]init];
            [btn addSubview:selectedView];
            [selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(btnW, 2));
                make.bottom.mas_equalTo(btn.mas_bottom);
                make.centerX.mas_equalTo(btn.mas_centerX);
            }];
            selectedView.backgroundColor = kWhiteColor;
            selectedView.tag = 50 + i;
            selectedView.hidden = YES;
            
        }
        
        UIView *bottomView = [[UIView alloc]init];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(frame.size.width, 0.5));
            make.bottom.mas_equalTo(self.mas_bottom);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        bottomView.backgroundColor = kWhiteColor;
        
    }
    return self;
}

- (void)btnAtcion:(UIButton *)btn {
    
    for (int i = 0; i < self.typeArray.count ; i++) {
        UIButton *button = self.subviews[i];
        UIView *selectView = [button viewWithTag:button.tag + 50];
        selectView.hidden = YES;
    }
    UIView *selectedView = [btn viewWithTag:btn.tag + 50];
    selectedView.hidden = NO;
    
    NSInteger index = [self.delegate touchWhitchBtn:btn.tag];
    
    NSLog(@"%ld" , index);
    
}

@end
