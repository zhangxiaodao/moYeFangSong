//
//  MYFeedBackTableViewCell.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/18.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYFeedBackTableViewCell.h"
#import "MYCalculateHeight.h"

@implementation MYFeedBackTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.backView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.backView];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:k15];
        [self.backView addSubview:self.contentLabel];
    }
    return self;
}

- (void)refreshCell:(NSString *)msg
{
    CGRect rec = [msg boundingRectWithSize:CGSizeMake(kScreenW * 2 / 3, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:k15]} context:nil];
    
    UIImage *image = nil;
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(rec.size.width + 20, rec.size.height + 20));
        make.right.mas_equalTo(self.contentView.mas_right).offset(- kScreenW / 37.5);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    image = [UIImage imageNamed:@"qiPao"];
    
    // 拉伸图片 参数1 代表从左侧到指定像素禁止拉伸，该像素之后拉伸，参数2 代表从上面到指定像素禁止拉伸，该像素以下就拉伸
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    self.backView.image = image;
    
    // 文本内容的frame
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(rec.size.width, rec.size.height));
        make.centerY.mas_equalTo(self.backView.mas_centerY);
        make.centerX.mas_equalTo(self.backView.mas_centerX);
    }];
    
    
    self.contentLabel.text = msg;
}


@end
