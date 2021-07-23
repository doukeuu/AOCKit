//
//  AOCNetworkConfig.m
//  AOCKit
//
//  Created by ssbm on 2021/5/8.
//

#import "AOCNetworkConfig.h"
#import "AOCNetworkConstant.h"

@implementation AOCNetworkConfig

// 默认配置
+ (AOCNetworkConfig *)defaultConfig {
    return [[AOCNetworkConfig alloc] initWithUrlPath:[apiUrlString copy]];
}

// 根据接口路径配置
- (instancetype)initWithUrlPath:(NSString *)urlPath {
    if (self = [super init]) {
        self.urlPath = urlPath;
        self.methodType = AOCHTTPMethodGET;
        self.requestType = AOCRequestSerializerTypeJSON;
        self.responseType = AOCResponseSerializerTypeJSON;
    }
    return self;
}

// 请求方法类型字符串
- (NSString *)methodName {
    switch (self.methodType) {
        case AOCHTTPMethodGET:    return @"GET";
        case AOCHTTPMethodPOST:   return @"POST";
        case AOCHTTPMethodPUT:    return @"PUT";
        case AOCHTTPMethodPATCH:  return @"PATCH";
        case AOCHTTPMethodDELETE: return @"DELETE";
        default:                  return @"GET";
    }
}

@end
