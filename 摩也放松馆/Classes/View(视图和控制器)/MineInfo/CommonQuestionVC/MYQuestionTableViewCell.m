//
//  MYQuestionTableViewCell.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/18.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYQuestionTableViewCell.h"
#import "MYCalculateHeight.h"
@interface MYQuestionTableViewCell ()
@property (nonatomic , strong) NSArray *titleArray;
@end

@implementation MYQuestionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
}

- (void)setLabelArray:(NSArray *)labelArray {
    _labelArray = labelArray;
    
    if (self.contentView.subviews.count > 0) {
        UIView *subView = self.contentView.subviews[0];
        [subView removeFromSuperview];
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, self.height)];
    [self.contentView addSubview:view];
    view.backgroundColor = kCOLOR(246, 252, 255);
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _labelArray.count; i++) {
        NSString *text = _labelArray[i];
        CGFloat labelHeight = [MYCalculateHeight calculateHeight:text fontSize:k13];
        labelHeight += 2;
        UILabel *label = [UILabel cz_labelWithText:text fontSize:k13 color:kMainColor textAligment:NSTextAlignmentLeft superView:view];
        NSLog(@"%f" , labelHeight);
        if (array.count == 0) {
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(view.mas_centerX);
                make.top.mas_equalTo(view.mas_top).offset(kScreenW / 25);
                make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 25, labelHeight));
            }];
        } else {
            UILabel *lastLabel = array[i - 1];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(view.mas_centerX);
                make.top.mas_equalTo(lastLabel.mas_bottom).offset(kScreenW / 25);
                make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 25, labelHeight));
            }];
        }
        [array addObject:label];
        
    }
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

@end
