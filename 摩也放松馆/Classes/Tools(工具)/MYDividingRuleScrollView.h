//
//  MYDividingRuleScrollView.h
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/7.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DISRULEMARGIN 8.f //刻度尺的左右间距
#define DISRULEVALUE 8.f //每刻度实际长度 8 个点
#define DISRULEWIDTH 20.f //标尺上下距离

@interface MYDividingRuleScrollView : UIScrollView

/**
 有多少个刻度
 */
@property (nonatomic , assign) NSInteger rulerCount;
/**
 刻度尺精度
 */
@property (nonatomic , strong) NSNumber *rulerAverage;
/**
 刻度尺高度
 */
@property (nonatomic , assign) NSInteger rulerHeight;
/**
 刻度尺宽度
 */
@property (nonatomic , assign) NSInteger rulerWidth;

/**
 刻度尺的当前值
 */
@property (nonatomic , assign) CGFloat  rulerValue;

/**
 平的
 */
@property (nonatomic , assign) BOOL horizontal;

/**
 使用 layer 层动画 画刻度
 */
- (void)drawRuler;

@end
