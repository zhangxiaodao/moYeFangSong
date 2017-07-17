//
//  MYBLETools.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/14.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYBLETools.h"
#import "UIAlertController+Custom.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface MYBLETools ()<CBCentralManagerDelegate , CBPeripheralDelegate>
@property (nonatomic , strong) NSMutableArray *discoverPeripherals;
@property (nonatomic , strong) CBCentralManager *manager;
@end

/**
 static SharedPerson *_person : 利用static关键字来确保创建的单例对象_person只能在此类中可以访问到；将_person定义成全局变量为了确保其生命周期存在于整个程序中，期间不被销毁.
 dispatch_once : 此函数确保_person对象在程序中只会创建一次，并且也保证了创建时的线程安全。
 + (instancetype)share : 提供便捷的类方法来创建单例对象，强烈建议用此法创建对象。
 + (instancetype)allocWithZone:(struct _NSZone *)zone : [SharedPerson alloc]分配对象内存时，实际会调此函数allocWithZone:(struct _NSZone *)zone，所以需要重写此方法来保证单例对象只会创建一次，而且是必须重写此方法，防止其他开发者直接用初始化方法来创建单例对象。
 */

static MYBLETools *_bleTools;

@implementation MYBLETools

+ (instancetype)shareBLE {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _bleTools = [[self alloc]init];
    });
    return _bleTools;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _bleTools = [super allocWithZone:zone];
    });
    return _bleTools;
}

- (void)initCentralManager {
    _manager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
    _discoverPeripherals = [NSMutableArray array];
}

- (void)writeValueServiceUUID:(NSString *)serviceUUID characteristicUUID:(NSString *)characteristicUUID data:(NSData *)data {
    CBUUID *suuid = [CBUUID UUIDWithString:serviceUUID];
    CBUUID *cuuid = [CBUUID UUIDWithString:characteristicUUID];
    
    for (CBPeripheral *peripheral in self.discoverPeripherals) {
        CBService *service = [self findServiceFromUUID:suuid p:peripheral];
        if (!service) return ;
        
        CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cuuid service:service];
        if (!characteristic) return ;
        
        if (characteristic.properties & CBCharacteristicPropertyWrite) {
            [peripheral writeValue:data
                 forCharacteristic:characteristic
                              type:CBCharacteristicWriteWithoutResponse];
        }
    }
    
}

- (void)readValue:(NSString *)serviceUUID characteristicUUID:(NSString *)characteristicUUID {
    CBUUID *suuid = [CBUUID UUIDWithString:serviceUUID];
    CBUUID *cuuid = [CBUUID UUIDWithString:characteristicUUID];
    
    for (CBPeripheral *peripheral in self.discoverPeripherals) {
        CBService *service = [self findServiceFromUUID:suuid p:peripheral];
        if (!service) return ;
        
        CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cuuid service:service];
        if (!characteristic) return ;
        
        if (characteristic.properties & CBCharacteristicPropertyRead) {
            [peripheral readValueForCharacteristic:characteristic];
        }
        
        
    }
}

-(void)notification:(NSString *)serviceUUID characteristicUUID:(NSString *)characteristicUUID on:(BOOL)on {
    CBUUID *suuid = [CBUUID UUIDWithString:serviceUUID];
    CBUUID *cuuid = [CBUUID UUIDWithString:characteristicUUID];
    
    for (CBPeripheral *peripheral in self.discoverPeripherals) {
        CBService *service = [self findServiceFromUUID:suuid p:peripheral];
        if (!service) return ;
        
        CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cuuid service:service];
        if (!characteristic) return ;
        
        if (characteristic.properties & CBCharacteristicPropertyNotify) {
            [peripheral setNotifyValue:on forCharacteristic:characteristic];
        }
        
    }
}


- (CBService *)findServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)p {
    for(int i = 0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        if ([s.UUID isEqual:UUID]) {
            return s;
        }
    }
    return nil;
}

- (CBCharacteristic *)findCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service {
    for(int i=0; i < service.characteristics.count; i++) {
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        if ([c.UUID isEqual:UUID]) {
            return c;
        }
    }
    return nil;
}


#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    //当蓝牙处于开启状态，开始扫描外设
    if (central.state == CBCentralManagerStatePoweredOn) {
        [central scanForPeripheralsWithServices:nil options:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [central stopScan];
            
            NSLog(@"%@" , self.discoverPeripherals);
        });
    } else {
        [UIAlertController creatCancleAndRightAlertControllerWithHandle:nil andSuperViewController:kWindowRoot Title:@"您的蓝牙未开启，无法添加设备"];
    }
}

/**
 扫描到外设会进入此方法
 
 @param central 中心管家
 @param peripheral 扫描到的外设
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSLog(@"当前连接到的外设是:%@" , peripheral.name);
    
    //链接外设 - 一个主设备最多只能连接7个外设，一个外设最多只能给一个主设备连接
    if ([peripheral.name hasPrefix:@"xxx"]) {
        
        if (_discoverPeripherals.count == 0) {
            [_discoverPeripherals addObject:peripheral];
        } else {
            for (int i = 0; i < _discoverPeripherals.count; i++) {
                CBPeripheral *p = _discoverPeripherals[i];
                if ([p.name isEqualToString:peripheral.name]) {
                    return ;
                }
            }
        }
        //中心管家连接外设
        [central connectPeripheral:peripheral options:nil];
    }
}

/**
 扫描外设失败
 
 @param central 中心管家
 @param peripheral 失败的外设
 @param error 失败的原因
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"连接设备%@失败,失败原因:%@" , peripheral.name , [error localizedDescription]);
}

/**
 外设断开链接

 @param central 中心管家
 @param peripheral 断开外设
 @param error 断开的原因
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"外设%@断开连接,断开原因是%@" , peripheral.name , [error localizedDescription]);
}

/**
 外设连接成功 - 开始扫描外设的服务
 
 @param central 中心管家
 @param peripheral 连接成功的外设
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"设备%@连接成功" , peripheral.name);
    
    peripheral.delegate = self;
    
    //扫描服务 Services - 参数为 nil ,扫描所有服务
    [peripheral discoverServices:nil];
}

#pragma mark - CBPeripheralDelegate
/**
 扫描到的外设的服务
 
 @param peripheral 外设
 @param error 错误原因
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    
    if (error) {
        NSLog(@"设备%@ 扫描服务失败，失败原因: %@", peripheral.name, [error localizedDescription]);
    }
    
    for (CBService *service in peripheral.services) {
        NSLog(@"设备%@ 扫描到的服务信息%@", peripheral.name , service.UUID);
        
        //扫描服务的特征
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

/**
 扫描服务的特征

 @param peripheral 外设
 @param service 外设服务
 @param error 失败的原因
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(nonnull CBService *)service error:(nullable NSError *)error {
    if (error)
    {
        NSLog(@"没有发现设备%@ 的服务UUID %@ 错误原因是%@", peripheral.name , service.UUID, [error localizedDescription]);
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"扫描的设备%@  的服务的UUID:%@ 的特征: %@", peripheral.name , service.UUID,characteristic.UUID);
        
        //获取 Characteristic 的值，读到的数据会进入-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
//        [peripheral readValueForCharacteristic:characteristic];
        
        //订阅这个characteristic，之后每当这个characteristic的value发生变化时，都会回调- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    }
}

/**
 获取到Characteristic 的值
 
 @param peripheral 外设
 @param characteristic 外设的特征
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"搜索到设备:%@ 的服务:%@ 的特征的UUID:%@  特征的值:%@ , 特征的属性%lu", peripheral.name , characteristic.service , characteristic.UUID,characteristic.value , (unsigned long)characteristic.properties);
}

/**
 获取到Characteristic 的值

 @param peripheral 外设
 @param characteristic 外设的特征
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"搜索到设备:%@ 的服务:%@ 的特征的UUID:%@  特征的值:%@ , 特征的属性%lu", peripheral.name , characteristic.service , characteristic.UUID,characteristic.value , (unsigned long)characteristic.properties);
    
}

@end
