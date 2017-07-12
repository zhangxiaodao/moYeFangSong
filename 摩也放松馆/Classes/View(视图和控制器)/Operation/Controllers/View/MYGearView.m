//
//  MYGearView.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/12.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYGearView.h"
#import "MYPickerView.h"

@interface MYGearView ()<MYPickerViewDataSource, MYPickerViewDelegate>
@property (nonatomic, strong) MYPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *titles;

@end

@implementation MYGearView

- (NSMutableArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray array];
        for (int i = 1; i < 31; i++) {
            [_titles addObject:[NSString stringWithFormat:@"%d" , i]];
        }
    }
    return _titles;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.pickerView = [[MYPickerView alloc] initWithFrame:CGRectMake(kScreenW / 12 + kScreenW / 25, 0, kScreenW / 1.2 - 2 * kScreenW / 25, frame.size.height)];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.pickerView];
        
        self.pickerView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:k30];
        self.pickerView.highlightedFont = [UIFont fontWithName:@"HelveticaNeue" size:k35];
        self.pickerView.textColor = kMainColor;
        self.pickerView.highlightedTextColor = kMainColor;
        self.pickerView.interitemSpacing = kScreenW / 6;
        self.pickerView.fisheyeFactor = 0.001;
        self.pickerView.pickerViewStyle = 1;
        self.pickerView.maskDisabled = false;
        
        [self.pickerView reloadData];
        
        
        UIButton *minusBtn = [UIButton cz_imageButton:@"minus" backgroundImageName:nil];
        [self addSubview:minusBtn];
        [minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 12 , kScreenW / 12));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).offset(kScreenW / 25);
        }];
        [minusBtn addTarget:self action:@selector(minusAtcion:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *addBtn = [UIButton cz_imageButton:@"add" backgroundImageName:nil];
        [self addSubview:addBtn];
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 12 , kScreenW / 12));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).offset(-kScreenW / 25);
        }];
        [addBtn addTarget:self action:@selector(addAtcion:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

#pragma mark - 按钮点击事件
- (void)addAtcion:(UIButton *)btn {

    self.pickerView.selectedItem++;
    
    if (self.pickerView.selectedItem >= 30) {
        self.pickerView.selectedItem = 29;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.pickerView.selectedItem inSection:0];
    [self.pickerView collectionView:(UICollectionView *)self.pickerView didSelectItemAtIndexPath:indexPath];
}

- (void)minusAtcion:(UIButton *)btn {
    
    if (self.pickerView.selectedItem == 0) {
        return ;
    }
    
    self.pickerView.selectedItem--;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.pickerView.selectedItem inSection:0];
    [self.pickerView collectionView:(UICollectionView *)self.pickerView didSelectItemAtIndexPath:indexPath];
}


#pragma mark - MYPickerViewDataSource

- (NSUInteger)numberOfItemsInPickerView:(MYPickerView *)pickerView
{
    return [self.titles count];
}

- (NSString *)pickerView:(MYPickerView *)pickerView titleForItem:(NSInteger)item
{
    return self.titles[item];
}

- (void)pickerView:(MYPickerView *)pickerView didSelectItem:(NSInteger)item
{
    NSNumber *index = @(item - 1);
    
    if (index == nil || index.intValue <= 0) {
        index = 0;
    }
    
    NSLog(@"%@", self.titles[index.intValue]);
}

@end
