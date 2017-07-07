//
//  NSAttributedString+CZAdditon.h
//
//  Created by 刘凡 on 16/4/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (CZAdditon)

/// 使用图像和文本生成上下排列的属性文本
///
/// @param image      图像
/// @param imageWH    图像宽高
/// @param title      标题文字
/// @param fontSize   标题字体大小
/// @param titleColor 标题颜色
/// @param spacing    图像和标题间距
///
/// @return 属性文本
+ (instancetype)cz_imageTextWithImage:(UIImage *)image
                              imageWH:(CGFloat)imageWH
                                title:(NSString *)title
                             fontSize:(CGFloat)fontSize
                           titleColor:(UIColor *)titleColor
                              spacing:(CGFloat)spacing;

/**
 设置 UILabel 的属性文本

 @param range 设置属性文本的截取位置
 @param attributedSize 属性文本的大小
 @param attributedColor 属性文本的颜色
 @param text text
 @return 属性文本
 */
+ (NSAttributedString *)cz_AttributedSubString:(NSRange)range
                        attributedSize:(CGFloat)attributedSize
                       attributedColor:(UIColor *)attributedColor
                                 text:(NSString *)text;

@end
