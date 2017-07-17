//
//  MYCalculateHeight.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/17.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYCalculateHeight.h"

@implementation MYCalculateHeight

+ (CGFloat)calculateHeight:(NSString *)text fontSize:(CGFloat)fontSize {
    CGFloat height = [text boundingRectWithSize:CGSizeMake(kScreenW / 1.25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.height;
    return height;
}

@end
