//
//  ViewController.m
//  aaaaa
//
//  Created by 杭州阿尔法特 on 2017/7/12.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str1 = @"A1,B1,C1,C2,B2,A2,D1,D2,D3";
    NSString *str2 = @"E1,E2,E3,F1,F2,F4";
    
    NSArray *strArray1 = @[@"A" , @"B" , @"C" , @"D" , @"E" , @"F"];
    NSArray *strArray2 = @[@"E" , @"F"];
    
    for (int i = 0; i < strArray1.count; i++) {
        NSLog(@"%@-->%@" , strArray1[i] , [self getDicOfStr:str1 subStr:strArray1[i]]);
    }
    
    for (int i = 0; i < strArray2.count; i++) {
        NSLog(@"%@-->%@" , strArray2[i] , [self getDicOfStr:str2 subStr:strArray2[i]]);
    }
    
}

- (NSDictionary *)getDicOfStr:(NSString *)sumStr subStr:(NSString *)subStr{
    NSArray *array = [sumStr componentsSeparatedByString:@","];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *aaa = [NSMutableArray array];
    for (NSString *str in array) {
        
        if ([str containsString:subStr]) {
            [aaa addObject:str];
            [dict setObject:aaa forKey:subStr];
        }
    }
    return dict;
}



@end
