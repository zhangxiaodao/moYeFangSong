//
//  MYWorkCollectionViewCell.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/12.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYWorkCollectionViewCell.h"

@interface MYWorkCollectionViewCell ()
@property (nonatomic , strong) UIImageView *imageView;
@end

@implementation MYWorkCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:imageView];
        imageView.frame = self.contentView.bounds;
        self.imageView = imageView;
        imageView.layer.cornerRadius = 5;
        imageView.layer.masksToBounds = YES;
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(3, 5);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 3;// 阴影扩散的范围控制
        
    }
    
    return self;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    self.imageView.image = [UIImage imageNamed:_imageName];
}

@end
