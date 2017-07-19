//
//  MYBirthdayViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/6.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYBirthdayViewController.h"
#import "MYHeightViewController.h"

@interface MYBirthdayViewController ()<UIPickerViewDelegate , UIPickerViewDataSource>
@property (nonatomic , strong) NSMutableArray *yearArray;
@property (nonatomic , strong) NSMutableArray *monthArray;
@property (nonatomic , strong) NSMutableArray *dayArray;
@property (nonatomic , strong) UIPickerView *mypickerView;
@end

@implementation MYBirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    
    self.titlelabel.text = @"请选择您的出生日期";
    self.backbtn.hidden = NO;
    self.nextbtn.hidden = NO;
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"birthday"]];
    [self.centerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.centerView.mas_centerX);
        make.top.mas_equalTo(self.centerView.mas_top);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 1.15, kScreenH / 1.64));
    }];
    
    UIPickerView *mypickerView = [[UIPickerView alloc]init];
    [self.centerView addSubview:mypickerView];
    [mypickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.centerView.mas_centerX);
        make.centerY.mas_equalTo(self.centerView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 1.3, 216));
    }];
    mypickerView.delegate = self;
    mypickerView.dataSource = self;
    self.mypickerView = mypickerView;
    
    NSInteger integer = [self.yearArray indexOfObject:@"1991"];
    [mypickerView selectRow:integer inComponent:0 animated:YES];
    
    NSArray *unitArray = @[@"年" , @"月" , @"日"];
    for (int i = 1; i <= 3; i++) {
        UILabel *unitlabel = [UILabel cz_labelWithText:unitArray[i - 1] fontSize:k15 color:kCOLOR(132, 145, 150) textAligment:NSTextAlignmentCenter superView:self.centerView];
        [unitlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.centerView.mas_centerY);
            
            if (i == 1) {
                make.left.mas_equalTo(self.centerView.mas_left).offset(i * kScreenW / 3.75 + kScreenW / 12.5);
            } else {
                make.left.mas_equalTo(self.centerView.mas_left).offset(i * kScreenW / 3.75);
            }
            
            make.size.mas_equalTo(CGSizeMake(kScreenW / 25, kScreenW / 25));
        }];
    }
    
}

- (void)nextbtnAtcion {
    
    [self getBirthday];
    
    MYHeightViewController *heightVC = [[MYHeightViewController alloc]init];
    heightVC.navigationItem.title = @"完善个人信息(3/5)";
    
    heightVC.model = self.model;
    [self.navigationController pushViewController:heightVC animated:YES];
}

- (void)getBirthday {
    NSString *year = self.yearArray[[self.mypickerView selectedRowInComponent:0]];
    NSString *month = self.monthArray[[self.mypickerView selectedRowInComponent:1]];
    NSString *day = self.dayArray[[self.mypickerView selectedRowInComponent:2]];
    
    NSString *birthday = [NSString stringWithFormat:@"%@-%@-%@" , year , month , day];
    
    self.model.birthday = birthday;
}

#pragma mark - UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.yearArray.count;
    } else if (component == 1) {
        return self.monthArray.count;
    } else {
        return self.dayArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return [self.yearArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.monthArray objectAtIndex:row];
    } else {
        return [self.dayArray objectAtIndex:row];
    }
    
}

#pragma mark - 取消 pickerView 的间隔线 设置字体
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    for(UIView *speartorView in pickerView.subviews)
    {
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            speartorView.backgroundColor = [UIColor clearColor];//隐藏分割线
        }
    }
    
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = kMainColor;
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:k25]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    return pickerLabel;
}

#pragma mark - 设置间距
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kScreenW / 7.5;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self getBirthday];
}

#pragma mark - 懒加载
- (NSMutableArray *)yearArray {
    if (!_yearArray) {
        _yearArray = [NSMutableArray array];
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:24 * 60 * 60];
        NSString *dateStr = [NSString stringWithFormat:@"%@" , date];
        NSString *subDate = [dateStr substringWithRange:NSMakeRange(0, 4)];
        for (int i = 100; i >= 0; i--) {
            [_yearArray addObject:[NSString stringWithFormat:@"%@" , @(subDate.integerValue - i)]];
        }
    }
    return _yearArray;
}

- (NSMutableArray *)monthArray {
    if (!_monthArray) {
        _monthArray = [NSMutableArray array];
        
        for (int i = 1; i <= 12; i++) {
            [_monthArray addObject:[NSString stringWithFormat:@"%@" , @(i)]];
        }
    }
    return _monthArray;
}

- (NSMutableArray *)dayArray {
    if (!_dayArray) {
        _dayArray = [NSMutableArray array];
        
        for (int i = 1; i <= 31; i++) {
            [_dayArray addObject:[NSString stringWithFormat:@"%@" , @(i)]];
        }
    }
    return _dayArray;
}

@end
