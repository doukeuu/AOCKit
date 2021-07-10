//
//  AOCDevice.m
//  AOCKit
//
//  Created by ssbm on 2021/5/11.
//

#import "AOCDevice.h"
#import <sys/utsname.h>

@implementation AOCDevice

// 设备名称
+ (NSString *)deviceName {
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine
                                                 encoding:NSUTF8StringEncoding];
    // simulator
    if ([deviceString isEqualToString:@"x86_64"]) return @"Simulator";
    // iPhone
    if ([deviceString isEqualToString:@"iPhone4,1"])   return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])   return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])   return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])   return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])   return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])   return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])   return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])   return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])   return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])   return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])   return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,3"])   return @"iPhoneSE";
    if ([deviceString isEqualToString:@"iPhone8,4"])   return @"iPhoneSE";
    if ([deviceString isEqualToString:@"iPhone9,1"])   return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])   return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])   return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])   return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])  return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])  return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])  return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,4"])  return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,5"])  return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,6"])  return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone11,2"])  return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,6"])  return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone11,8"])  return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPhone12,1"])  return @"iPhone 11";
    if ([deviceString isEqualToString:@"iPhone12,3"])  return @"iPhone 11 Pro";
    if ([deviceString isEqualToString:@"iPhone12,5"])  return @"iPhone 11 Pro Max";
    if ([deviceString isEqualToString:@"iPhone12,8"])  return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone13,1"])  return @"iPhone 12 mini";
    if ([deviceString isEqualToString:@"iPhone13,2"])  return @"iPhone 12";
    if ([deviceString isEqualToString:@"iPhone13,3"])  return @"iPhone 12 Pro";
    if ([deviceString isEqualToString:@"iPhone13,4"])  return @"iPhone 12 Pro Max";
    // iPad mini
    if ([deviceString isEqualToString:@"iPad2,5"])   return @"iPad mini";
    if ([deviceString isEqualToString:@"iPad2,6"])   return @"iPad mini";
    if ([deviceString isEqualToString:@"iPad2,7"])   return @"iPad mini";
    if ([deviceString isEqualToString:@"iPad4,4"])   return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,5"])   return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,6"])   return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])   return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])   return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])   return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])   return @"iPad mini 4";
    if ([deviceString isEqualToString:@"iPad5,2"])   return @"iPad mini 4";
    if ([deviceString isEqualToString:@"iPad11,1"])  return @"iPad mini 5";
    if ([deviceString isEqualToString:@"iPad11,2"])  return @"iPad mini 5";
    // iPad Air
    if ([deviceString isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])   return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])   return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad11,3"])  return @"iPad Air 3";
    if ([deviceString isEqualToString:@"iPad11,4"])  return @"iPad Air 3";
    if ([deviceString isEqualToString:@"iPad13,1"])  return @"iPad Air 4";
    if ([deviceString isEqualToString:@"iPad13,2"])  return @"iPad Air 4";
    // iPad
    if ([deviceString isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([deviceString isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([deviceString isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([deviceString isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([deviceString isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([deviceString isEqualToString:@"iPad3,6"])   return @"iPad4";
    if ([deviceString isEqualToString:@"iPad6,11"])  return @"iPad5";
    if ([deviceString isEqualToString:@"iPad6,12"])  return @"iPad5";
    if ([deviceString isEqualToString:@"iPad7,5"])   return @"iPad6";
    if ([deviceString isEqualToString:@"iPad7,6"])   return @"iPad6";
    if ([deviceString isEqualToString:@"iPad7,11"])  return @"iPad7";
    if ([deviceString isEqualToString:@"iPad7,12"])  return @"iPad7";
    if ([deviceString isEqualToString:@"iPad11,6"])  return @"iPad8";
    if ([deviceString isEqualToString:@"iPad11,7"])  return @"iPad8";
    // iPad Pro
    if ([deviceString isEqualToString:@"iPad6,3"])   return @"iPad Pro(9.7-inch)";
    if ([deviceString isEqualToString:@"iPad6,4"])   return @"iPad Pro(9.7-inch)";
    if ([deviceString isEqualToString:@"iPad6,7"])   return @"iPad Pro(12.9-inch)";
    if ([deviceString isEqualToString:@"iPad6,8"])   return @"iPad Pro(12.9-inch)";
    if ([deviceString isEqualToString:@"iPad7,1"])   return @"iPad Pro 2(12.9-inch)";
    if ([deviceString isEqualToString:@"iPad7,2"])   return @"iPad Pro 2(12.9-inch)";
    if ([deviceString isEqualToString:@"iPad7,3"])   return @"iPad Pro(10.5-inch)";
    if ([deviceString isEqualToString:@"iPad7,4"])   return @"iPad Pro(10.5-inch)";
    if ([deviceString isEqualToString:@"iPad8,1"])   return @"iPad Pro(11-inch)";
    if ([deviceString isEqualToString:@"iPad8,2"])   return @"iPad Pro(11-inch)";
    if ([deviceString isEqualToString:@"iPad8,3"])   return @"iPad Pro(11-inch)";
    if ([deviceString isEqualToString:@"iPad8,4"])   return @"iPad Pro(11-inch)";
    if ([deviceString isEqualToString:@"iPad8,5"])   return @"iPad Pro 3(12.9-inch)";
    if ([deviceString isEqualToString:@"iPad8,6"])   return @"iPad Pro 3(12.9-inch)";
    if ([deviceString isEqualToString:@"iPad8,7"])   return @"iPad Pro 3(12.9-inch)";
    if ([deviceString isEqualToString:@"iPad8,8"])   return @"iPad Pro 3(12.9-inch)";
    if ([deviceString isEqualToString:@"iPad8,9"])   return @"iPad Pro 2(11-inch)";
    if ([deviceString isEqualToString:@"iPad8,10"])  return @"iPad Pro 2(11-inch)";
    if ([deviceString isEqualToString:@"iPad8,11"])  return @"iPad Pro 4(12.9-inch)";
    if ([deviceString isEqualToString:@"iPad8,12"])  return @"iPad Pro 4(12.9-inch)";
    
    return deviceString;
}

@end
