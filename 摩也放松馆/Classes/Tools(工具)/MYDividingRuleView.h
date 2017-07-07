//
//  MYDividingRuleView.h
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/7.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYDividingRuleScrollView.h"

@protocol MYDividingRuleViewDelegate <NSObject>

- (void)dividingRuleCurrentVaule:(MYDividingRuleScrollView *)rulerScrollView;

@end

@interface MYDividingRuleView : UIView

@property (nonatomic , strong) MYDividingRuleScrollView *rulerScrollView;;
@property (nonatomic , assign) id<MYDividingRuleViewDelegate>   rulerDelegate;

/**
 实例化刻度尺对象
 
 @param count 总刻度的数量
 @param average 刻度尺的精度
 @param currentValue 当前刻度尺的值
 @param horizontal 是否水平
 */
+ (MYDividingRuleView *)showRulerWithFrame:(CGRect)frame
                 ruleCount:(NSInteger)count
                   average:(NSNumber *)average
              currentValue:(CGFloat)currentValue
                horizontal:(BOOL)horizontal;

@end
