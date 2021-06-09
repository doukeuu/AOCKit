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

- (instancetype)initWithUrlPath:(NSString *)urlPath {
    if (self = [super init]) {
        self.urlPath = urlPath;
        self.methodType = AOCHTTPMethodGET;
        self.requestType = AOCRequestSerializerTypeJSON;
        self.responseType = AOCResponseSerializerTypeJSON;
    }
    return self;
}

- (instancetype)initWithUrlPath:(NSString *)urlPath
                     methodType:(AOCHTTPMethodType)methodType {
    if (self = [super init]) {
        self.urlPath = urlPath;
        self.methodType = methodType;
        self.requestType = AOCRequestSerializerTypeJSON;
        self.responseType = AOCResponseSerializerTypeJSON;
    }
    return self;
}

- (instancetype)initWithUrlPath:(NSString *)urlPath
                     methodType:(AOCHTTPMethodType)methodType
                    requestType:(AOCRequestSerializerType)requestType {
    if (self = [super init]) {
        self.urlPath = urlPath;
        self.methodType = methodType;
        self.requestType = requestType;
        self.responseType = AOCResponseSerializerTypeJSON;
    }
    return self;
}

- (instancetype)initWithUrlPath:(NSString *)urlPath
                     methodType:(AOCHTTPMethodType)methodType
                    requestType:(AOCRequestSerializerType)requestType
                   responseType:(AOCResponseSerializerType)responseType {
    if (self = [super init]) {
        self.urlPath = urlPath;
        self.methodType = methodType;
        self.requestType = requestType;
        self.responseType = responseType;
    }
    return self;
}

@end
