//
//  UILabel+CZAddition.h
//
//  Created by 刘凡 on 16/4/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CZAddition)

/// 创建文本标签
///
/// @param text     文本
/// @param fontSize 字体大小
/// @param color    颜色
///
/// @return UILabel
+ (instancetype)cz_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color textAligment:(NSTextAlignment)modle superView:(id)superView;

/**
 创建 UILabel，并设置属性文本
 
 @param text label 的 text
 @param fontSize label 的 字体大小
 @param color 字体颜色
 @param modle 字体是否居中
 @param range 设置属性文本的截取位置
 @param attributedSize 属性文本的大小
 @param attributedColor 属性文本的颜色
 @param superView 父视图
 @return UILabel
 */
+ (instancetype)cz_labelAttributedWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color textAligment:(NSTextAlignment)modle subString:(NSRange)range attributedSize:(CGFloat)attributedSize attributedColor:(UIColor *)attributedColor superView:(id)superView;



@end
