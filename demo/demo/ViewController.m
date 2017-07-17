//
//  ViewController.m
//  demo
//
//  Created by 杭州阿尔法特 on 2017/7/13.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UInt16 s = [self swap:0x1802];
    
    
}


-(UInt16) swap:(UInt16)s {
    UInt16 temp = s << 8;
    temp |= (s >> 8);
    return temp;
}

@end
