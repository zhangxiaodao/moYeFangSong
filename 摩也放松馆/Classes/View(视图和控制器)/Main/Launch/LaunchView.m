//
//  LaunchView.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "LaunchView.h"

@interface LaunchView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation LaunchView

+ (LaunchView *)createLaunchView {
    UINib *nib = [UINib nibWithNibName:@"LaunchView" bundle:nil];
    LaunchView *view = (LaunchView *)[nib instantiateWithOwner:nil options:nil].firstObject;
    
    view.frame = kScreenFrame;
    
    return view;
}

@end
