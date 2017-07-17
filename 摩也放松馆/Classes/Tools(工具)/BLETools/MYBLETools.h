//
//  MYBLETools.h
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/14.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYBLETools : NSObject

/**
 单利
 */
+ (instancetype)shareBLE;

/**
 初始化 中心管家
 */
- (void)initCentralManager;

/**
 向外设的serviceUUID服务的characteristicUUID特征写数据

 @param serviceUUID 外设的某一服务
 @param characteristicUUID 服务的某一特征
 @param data 要写的数据
 */
- (void)writeValueServiceUUID:(NSString *)serviceUUID characteristicUUID:(NSString *)characteristicUUID data:(NSData *)data;

/**
 从外设的某一服务的某一特征读数据

 @param serviceUUID 外设的某一服务
 @param characteristicUUID 服务的某一特征
 */
- (void)readValue:(NSString *)serviceUUID characteristicUUID:(NSString *)characteristicUUID;

/**
 订阅这个characteristic，之后每当这个characteristic的value发生变化时，都会回调 didUpdateValueForCharacteristic

 @param serviceUUID 外设的某一服务
 @param characteristicUUID 服务的某一特征
 @param on 订阅的 打开或关闭
 */
-(void)notification:(NSString *)serviceUUID characteristicUUID:(NSString *)characteristicUUID on:(BOOL)on;

@end
