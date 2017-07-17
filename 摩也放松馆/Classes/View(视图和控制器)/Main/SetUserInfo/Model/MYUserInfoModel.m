//
//  MYUserInfoModel.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/17.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYUserInfoModel.h"

@implementation MYUserInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"_sex--->%@\n , _birthday--->%@\n , _height--->%@\n , _weight--->%@\n , _phoneNumber--->%@\n" , _sex , _birthday , _height , _weight , _phoneNumber];
}

@end
