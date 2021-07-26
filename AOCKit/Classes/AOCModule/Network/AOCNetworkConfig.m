//
//  AOCNetworkConfig.m
//  AOCKit
//
//  Created by ssbm on 2021/5/8.
//

#import "AOCNetworkConfig.h"

@implementation AOCNetworkConfig

- (instancetype)init {
    if (self = [super init]) {
        [self initialConfig];
    }
    return self;
}

// 根据接口路径配置
- (instancetype)initWithUrlPath:(NSString *)urlPath {
    if (self = [super init]) {
        self.urlPath = urlPath;
        [self initialConfig];
    }
    return self;
}

// 初始化属性
- (void)initialConfig {
    self.methodType = AOCHTTPMethodGET;
    self.requestType = AOCRequestSerializerTypeJSON;
    self.responseType = AOCResponseSerializerTypeJSON;
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
