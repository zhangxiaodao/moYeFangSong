//
//  MYDividingRuleScrollView.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/7.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYDividingRuleScrollView.h"

@implementation MYDividingRuleScrollView

- (void)setRulerValue:(CGFloat)rulerValue {
    _rulerValue = rulerValue;
}

- (void)drawRuler {
    CGMutablePathRef pathRef1 = CGPathCreateMutable();
    CGMutablePathRef pathRef2 = CGPathCreateMutable();
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.lineWidth = 1.0;
    shapeLayer1.lineCap = kCALineCapButt;
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.lineWidth = 1.0;
    shapeLayer2.lineCap = kCALineCapButt;
    
    for (int i = 0; i <= self.rulerCount; i++) {
        UILabel *rule = [UILabel cz_labelWithText:[NSString stringWithFormat:@"%.0f",i * [self.rulerAverage floatValue]] fontSize:k15 color:[UIColor lightGrayColor] textAligment:NSTextAlignmentCenter superView:nil];
        CGSize textSize = [rule.text sizeWithAttributes:@{NSFontAttributeName:rule.font}];
        
        if (self.horizontal) {
            if (i % 5 == 0) {
                CGPathMoveToPoint(pathRef2, nil, DISRULEMARGIN + DISRULEVALUE * i, 1);
                CGPathAddLineToPoint(pathRef2, nil, DISRULEMARGIN + DISRULEVALUE * i , self.rulerHeight / 3);
                rule.frame = CGRectMake(DISRULEMARGIN + DISRULEVALUE * i - textSize.height / 2, self.rulerHeight / 2, 0, 0);
                [rule sizeToFit];
                [self addSubview:rule];
                
            } else {
                CGPathMoveToPoint(pathRef1, nil, DISRULEMARGIN + DISRULEVALUE * i, 1);
                CGPathAddLineToPoint(pathRef1, nil, DISRULEMARGIN + DISRULEVALUE * i, self.rulerHeight / 6);
            }
        } else {
            if (i % 5 == 0) {
                CGPathMoveToPoint(pathRef2, nil, 1, DISRULEMARGIN + DISRULEVALUE * i);
                CGPathAddLineToPoint(pathRef2, nil, self.rulerWidth / 3 , DISRULEMARGIN + DISRULEVALUE * i);
                rule.frame = CGRectMake(self.rulerWidth / 2, DISRULEMARGIN + DISRULEVALUE * i - textSize.height / 2, 0, 0);
                [rule sizeToFit];
                [self addSubview:rule];
                
            } else {
                CGPathMoveToPoint(pathRef1, nil, 1, DISRULEMARGIN + DISRULEVALUE * i);
                CGPathAddLineToPoint(pathRef1, nil, self.rulerWidth / 6, DISRULEMARGIN + DISRULEVALUE * i);
            }
        }
        
        
    }
    
    shapeLayer1.path = pathRef1;
    shapeLayer2.path = pathRef2;
    
    [self.layer addSublayer:shapeLayer1];
    [self.layer addSublayer:shapeLayer2];
    
    self.frame = CGRectMake(0, 0, self.rulerWidth, self.rulerHeight);
    
    //是否为横屏
    if (_horizontal) {
        self.contentOffset = CGPointMake(DISRULEVALUE * (self.rulerValue / [self.rulerAverage floatValue]) - self.rulerWidth / 2 + DISRULEMARGIN, 0);
        self.contentSize = CGSizeMake(self.rulerCount * DISRULEVALUE + DISRULEMARGIN * 2.f, self.rulerHeight);
    } else {
        self.contentOffset = CGPointMake(0, DISRULEVALUE * (self.rulerValue / [self.rulerAverage floatValue]) - self.rulerHeight / 2 + DISRULEMARGIN);
        self.contentSize = CGSizeMake(self.rulerWidth, self.rulerCount * DISRULEVALUE + DISRULEMARGIN * 2.f);
    }
}

@end
