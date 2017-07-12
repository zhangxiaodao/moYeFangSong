//
//  CZBtnView.h
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/6.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZBtnView : UIView

- (CZBtnView *_Nullable)initCZBtnViewOf:(NSString *_Nullable)title fontSize:(CGFloat)fontSize normalColor:(UIColor *_Nullable)normalColor highlightedColor:(UIColor *_Nullable)highlightedColor addTarget:(nullable id)target action:(nonnull SEL)action;

@property (nonatomic , copy) NSString * title;

@end
