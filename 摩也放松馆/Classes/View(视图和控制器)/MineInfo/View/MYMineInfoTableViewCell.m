//
//  MYMineInfoTableViewCell.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/10.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYMineInfoTableViewCell.h"

@interface MYMineInfoTableViewCell ()
@property (nonatomic , strong) UIImageView *imageViw;
@property (nonatomic ,strong) UILabel *lable;
@property (nonatomic , strong) UIView *topView;
@property (nonatomic , strong) UIView *centerView;
@property (nonatomic , strong) UIView *bottomView;

@property (nonatomic , strong) NSMutableArray *nameArray;
@property (nonatomic , strong) NSMutableArray *imageArray;

@end

@implementation MYMineInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW / 5.8)];
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:nil];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.height / 3 + 8, view.height / 3 + 8));
        make.left.mas_equalTo(view.mas_left).offset(kScreenW / 29);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    self.imageViw = imageView;
    
    
    UILabel *label = [UILabel cz_labelWithText:@"" fontSize:k15 color:kCOLOR(155, 162, 172) textAligment:NSTextAlignmentLeft superView:view];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, view.height * 1 / 3));
        make.left.mas_equalTo(imageView.mas_right).offset(kScreenW / 29);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    self.lable = label;
    
    UIImageView *jianTouImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tab_return"]];
    [view addSubview:jianTouImage];
    [jianTouImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 50, kScreenW / 30));
        make.right.mas_equalTo(view.mas_right).offset(-kScreenW / 29);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    jianTouImage.transform = CGAffineTransformRotate(jianTouImage.transform, M_PI);
    jianTouImage.contentMode = UIViewContentModeScaleAspectFit;
    
    UIView *topView = [[UIView alloc] init];
    [view addSubview:topView];
    topView.backgroundColor = kCOLOR(219, 219, 221);
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
        make.right.mas_equalTo(view.mas_right);
        make.top.mas_equalTo(view.mas_top);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    [view addSubview:bottomView];
    bottomView.backgroundColor = kCOLOR(219, 219, 221);
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
        make.right.mas_equalTo(view.mas_right);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
    
    UIView *centerView = [[UIView alloc] init];
    [view addSubview:centerView];
    centerView.backgroundColor = kCOLOR(219, 219, 221);
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 29, 1));
        make.right.mas_equalTo(view.mas_right);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
 
    self.topView = topView;
    self.centerView = centerView;
    self.bottomView = bottomView;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    if (_indexPath.section == 0) {
        if (_indexPath.row == 0) {
            self.centerView.hidden = YES;
        }
    }
    
    if (_indexPath.section == 1) {
        if (_indexPath.row == 0) {
            self.bottomView.hidden = YES;
        } else if (_indexPath.row == 1) {
            self.topView.hidden = YES;
            self.centerView.hidden = YES;
        }
    }
    
    if (_indexPath.section == 2 && _indexPath.row == 0) {
        self.centerView.hidden = YES;
    }
    
    NSArray *imageAy = self.imageArray[_indexPath.section];
    NSString *imageName = imageAy[_indexPath.row];
    self.imageViw.image = [UIImage imageNamed:imageName];
    
    NSArray *textAy = self.nameArray[indexPath.section];
    self.lable.text = textAy[_indexPath.row];
}

- (NSMutableArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [NSMutableArray array];
        [_nameArray addObject:@[@"个人信息"]];
        [_nameArray addObject:@[@"常见问题" ,@"意见反馈"]];
        [_nameArray addObject:@[@"关于"]];
    }
    return _nameArray;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
        [_imageArray addObject:@[@"userInfo"]];
        [_imageArray addObject:@[@"question" , @"message"]];
        [_imageArray addObject:@[@"about"]];
    }
    return _imageArray;
}

@end
