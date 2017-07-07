//
//  UILabel+CZAddition.m
//
//  Created by 刘凡 on 16/4/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UILabel+CZAddition.h"

@implementation UILabel (CZAddition)

+ (instancetype)cz_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color textAligment:(NSTextAlignment)modle superView:(id)superView{
    UILabel *label = [[self alloc] init];
    
    
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    label.numberOfLines = 0;
    label.textAlignment = modle;
    [label sizeToFit];
    
    [superView addSubview:label];
    return label;
}

+ (instancetype)cz_labelAttributedWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color textAligment:(NSTextAlignment)modle subString:(NSRange)range attributedSize:(CGFloat)attributedSize attributedColor:(UIColor *)attributedColor superView:(id)superView {
    UILabel *label = [self cz_labelWithText:text fontSize:fontSize color:color textAligment:modle superView:superView];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:attributedColor range:range];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontWithName size:attributedSize] range:range];
    label.attributedText = str;
    
    return label;
}
@end
