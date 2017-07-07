//
//  LaunchView.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "LaunchView.h"
#import "MYNavViewController.h"
#import "MYSexViewController.h"

@interface LaunchView ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic , strong) CZBtnView *btn;
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
    

    CZBtnView *btnView = [[CZBtnView alloc]initCZBtnViewOf:@"开启放松1.0时代" fontSize:k20 normalColor:kMainColor highlightedColor:nil  addTarget:self action:@selector(clickAtcion)];
    [self addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 1.75, kScreenW / 7.5));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-kScreenW / 12.5);
    }];
    btnView.hidden = YES;
    self.btn = btnView;
    
}

#pragma mark - clickAtcion
- (void)clickAtcion {
    [self removeFromSuperview];

    [kStanderDefault setObject:@"NO" forKey:@"FirstUse"];
    
    MYSexViewController *sexVC = [[MYSexViewController alloc]init];
    MYNavViewController *nav = [[MYNavViewController alloc]initWithRootViewController:sexVC];
    sexVC.navigationItem.title = @"完善个人信息(1/5)";
    kWindowRoot = nav;
    
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //1.计算当前偏移量
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.btn.hidden = (page != scrollView.subviews.count - 1);
    }];
}

@end
