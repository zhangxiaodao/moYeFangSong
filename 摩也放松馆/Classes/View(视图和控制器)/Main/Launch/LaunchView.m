//
//  LaunchView.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "LaunchView.h"

@interface LaunchView ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic , strong) UIButton *btn;
@end

@implementation LaunchView

+ (LaunchView *)createLaunchView {
    UINib *nib = [UINib nibWithNibName:@"LaunchView" bundle:nil];
    LaunchView *view = (LaunchView *)[nib instantiateWithOwner:nil options:nil].firstObject;
    
    view.frame = kScreenFrame;
    
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSInteger count = 3;
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    for (int i = 0; i < count; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Launch%d" , i]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.frame = CGRectOffset(rect, i * rect.size.width, 0);
        [self.scrollView addSubview:imageView];
    }
    
    //设置 scrollView 的属性
    _scrollView.contentSize = CGSizeMake(count * rect.size.width, rect.size.height);
    _scrollView.delegate = self;
    
    
    UIButton *btn = [UIButton cz_textButton:@"开启放松1.0时代" fontSize:k20 backGroundNormalColor:kCOLOR(99, 203, 248) backGroundHighlightedColor:kCOLOR(60, 155, 235)];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 1.75, kScreenW / 7.5));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-kScreenW / 12.5);
    }];
    btn.hidden = YES;
    self.btn = btn;
    
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //1.计算当前偏移量
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.btn.hidden = (page != scrollView.subviews.count - 2);
    }];
}

@end
