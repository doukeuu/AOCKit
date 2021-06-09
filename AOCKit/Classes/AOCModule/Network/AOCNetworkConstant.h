//
//  AOCNetworkConstant.h
//  AOCKit
//
//  Created by ssbm on 2021/5/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString const * _Nonnull apiUrlString;   // 接口IP地址
FOUNDATION_EXPORT NSString const * _Nonnull imgUrlString;   // 图片IP地址
FOUNDATION_EXPORT NSString const * _Nonnull webUrlString;   // 网页IP地址
FOUNDATION_EXPORT NSString const * _Nonnull shareUrlString; // 分享IP地址

/// 拼接基础URL到图片地址
inline static NSString * splicingImgUrlForPath(NSString *string) {
    if ([string containsString:@"http"] || [string containsString:@"HTTP"]) {
        return string;
    }else{
        return [NSString stringWithFormat:@"%@%@", imgUrlString, string];
    }
}

NS_ASSUME_NONNULL_END
