//
//  MYFeedBackTableViewCell.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/18.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYFeedBackTableViewCell.h"
#import "MYCalculateHeight.h"

@interface MYFeedBackTableViewCell ()
@property (nonatomic , strong) UIView *view;
@end

@implementation MYFeedBackTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)refreshCell:(NSString *)msg rec:(CGRect)rec
{
    
    for (int i = 0; i < self.contentView.subviews.count; i++) {
        UIView *subView = self.contentView.subviews[i];
        [subView removeFromSuperview];
    }
    
    UIImage *image = nil;
    
    self.backView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(rec.size.width + 50, rec.size.height + 30));
        make.right.mas_equalTo(self.contentView.mas_right).offset(- kScreenW / 37.5);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    image = [UIImage imageNamed:@"qiPao"];
    
    // 拉伸图片 参数1 代表从左侧到指定像素禁止拉伸，该像素之后拉伸，参数2 代表从上面到指定像素禁止拉伸，该像素以下就拉伸
    image = [image stretchableImageWithLeftCapWidth:image.size.width / 3 topCapHeight:image.size.height/2];
    self.backView.image = image;
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:k15];
    [self.backView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(rec.size.width, rec.size.height + 10));
        make.centerY.mas_equalTo(self.backView.mas_centerY);
        make.centerX.mas_equalTo(self.backView.mas_centerX);
    }];
    
    
    self.contentLabel.text = msg;
}


@end
