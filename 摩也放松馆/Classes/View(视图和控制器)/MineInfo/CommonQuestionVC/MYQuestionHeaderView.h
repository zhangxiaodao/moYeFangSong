//
//  MYQuestionHeaderView.h
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/17.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYQuestionHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame withText:(NSString *)text;

@property (nonatomic , strong) UIImageView *imageView;

@end
