//
//  MYOperationCell.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/7.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYOperationCell.h"

@interface MYOperationCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@end

@implementation MYOperationCell

- (void)setText:(NSString *)text {
    _text = text;
    
    if (_text) {
        self.titleLabel.text = text;
    }
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    if (_imageName) {
        self.backImage.image = [UIImage imageNamed:_imageName];
    }
}

@end
