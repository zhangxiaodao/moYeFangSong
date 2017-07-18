//
//  MYFeedBackTableViewCell.h
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/18.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYFeedBackTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *backView; // 气泡
@property (nonatomic,strong) UILabel *contentLabel; // 气泡内文本

- (void)refreshCell:(NSString *)msg; // 安装我们的cell

@end
