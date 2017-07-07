//
//  MYDividingRuleView.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/7.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYDividingRuleView.h"

@interface MYDividingRuleView ()<UIScrollViewDelegate>

@property (nonatomic , assign) NSInteger rulerCount;
@property (nonatomic , strong) NSNumber *rulerAverage;
@property (nonatomic , assign) CGFloat  rulerValue;
@property (nonatomic , assign) BOOL horizontal;

@end

@implementation MYDividingRuleView

- (instancetype)initWithFrame:(CGRect)frame ruleCount:(NSInteger)count average:(NSNumber *)average currentValue:(CGFloat)currentValue horizontal:(BOOL)horizontal {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = kCOLOR(237, 247, 255);
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = kMainColor.CGColor;
        self.layer.cornerRadius = 3;
        
        _rulerScrollView = [[MYDividingRuleScrollView alloc]init];
        _rulerScrollView.delegate = self;
        _rulerScrollView.showsVerticalScrollIndicator = NO;
        _rulerScrollView.showsHorizontalScrollIndicator = NO;
        _rulerScrollView.rulerWidth = frame.size.width;
        _rulerScrollView.rulerHeight = frame.size.height;
        _rulerScrollView.rulerAverage = average;
        _rulerScrollView.rulerCount = count;
        _rulerScrollView.rulerValue = currentValue;
        _rulerScrollView.horizontal = horizontal;
        
        self.horizontal = horizontal;
        
        [_rulerScrollView drawRuler];
        [self addSubview:_rulerScrollView];

        
    }
    return self;
}

+ (MYDividingRuleView *)showRulerWithFrame:(CGRect)frame ruleCount:(NSInteger)count average:(NSNumber *)average currentValue:(CGFloat)currentValue horizontal:(BOOL)horizontal {
    MYDividingRuleView *ruleView = [[MYDividingRuleView alloc]initWithFrame:frame ruleCount:count average:average currentValue:currentValue horizontal:horizontal];
    
    
    return ruleView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(MYDividingRuleScrollView *)scrollView {
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;
    CGFloat ruleValue = 0;
    if (self.horizontal) {
        offsetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISRULEMARGIN;
        ruleValue = (offsetX / DISRULEVALUE) * [scrollView.rulerAverage floatValue];
    } else {
        offsetY = scrollView.contentOffset.y + self.frame.size.height / 2 - DISRULEMARGIN;
        ruleValue = (offsetY / DISRULEVALUE) * [scrollView.rulerAverage floatValue];
    }
    
    if (ruleValue < 0.f) {
        return ;
    } else if (ruleValue > scrollView.rulerCount * [scrollView.rulerAverage floatValue]) {
        return ;
    }
    
    scrollView.rulerValue = ruleValue;
    
    if (_rulerDelegate) {
        [_rulerDelegate dividingRuleCurrentVaule:scrollView];
    }
    
}

- (void)scrollViewDidEndDecelerating:(MYDividingRuleScrollView *)scrollView {
    [self animationRebound:scrollView];
}

- (void)scrollViewDidEndDragging:(MYDividingRuleScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self animationRebound:scrollView];
}

- (void)animationRebound:(MYDividingRuleScrollView *)scrollView {
    
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;
    
    CGFloat value = 0;
    
    if (self.horizontal) {
        offsetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISRULEMARGIN;
        value = (offsetX / DISRULEVALUE) * [scrollView.rulerAverage floatValue];
    } else {
        offsetY = scrollView.contentOffset.y + self.frame.size.height / 2 - DISRULEMARGIN;
        value = (offsetY / DISRULEVALUE) * [scrollView.rulerAverage floatValue];
    }
    
    if ([self valueIsInteger:scrollView.rulerAverage]) {
        value = [self notRounding:value afterPoint:0];
    } else {
        value = [self notRounding:value afterPoint:1];
    }
    
    if (self.horizontal) {
        CGFloat offX = (value / [scrollView.rulerAverage floatValue]) * DISRULEVALUE + DISRULEMARGIN - self.frame.size.width / 2;
        [UIView animateWithDuration:.2 animations:^{
            scrollView.contentOffset = CGPointMake(offX, 0);
        }];
    } else {
        CGFloat offY = (value / [scrollView.rulerAverage floatValue]) * DISRULEVALUE + DISRULEMARGIN - self.frame.size.height / 2;
        [UIView animateWithDuration:.2 animations:^{
            scrollView.contentOffset = CGPointMake(0, offY);
        }];
    }
    
    
    
}


#pragma mark - tool method

- (CGFloat)notRounding:(CGFloat)price afterPoint:(NSInteger)position {
    NSDecimalNumberHandler*roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber*ouncesDecimal;
    NSDecimalNumber*roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc]initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [roundedOunces floatValue];
}

- (BOOL)valueIsInteger:(NSNumber *)number {
    NSString *value = [NSString stringWithFormat:@"%f",[number floatValue]];
    if (value != nil) {
        NSString *valueEnd = [[value componentsSeparatedByString:@"."] objectAtIndex:1];
        NSString *temp = nil;
        for(int i =0; i < [valueEnd length]; i++)
        {
            temp = [valueEnd substringWithRange:NSMakeRange(i, 1)];
            if (![temp isEqualToString:@"0"]) {
                return NO;
            }
        }
    }
    return YES;
}

@end
