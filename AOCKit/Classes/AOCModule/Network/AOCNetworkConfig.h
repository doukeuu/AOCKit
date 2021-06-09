//
//  AOCNetworkConfig.h
//  AOCKit
//
//  Created by ssbm on 2021/5/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 请求方法类型
typedef NS_ENUM(NSInteger, AOCHTTPMethodType) {
    /// get
    AOCHTTPMethodGET = 0,
    /// head
    AOCHTTPMethodHEAD,
    /// post
    AOCHTTPMethodPOST,
    /// put
    AOCHTTPMethodPUT,
    /// patch
    AOCHTTPMethodPATCH,
    /// delete
    AOCHTTPMethodDELETE,
};

/// 请求序列化类型
typedef NS_ENUM(NSInteger, AOCRequestSerializerType) {
    /// json
    AOCRequestSerializerTypeJSON = 0,
    /// http
    AOCRequestSerializerTypeHTTP
};

/// 响应序列化类型
typedef NS_ENUM(NSInteger, AOCResponseSerializerType) {
    /// json
    AOCResponseSerializerTypeJSON = 0,
    /// http
    AOCResponseSerializerTypeHTTP,
    /// compound
    AOCResponseSerializerTypeCompound
};


@interface AOCNetworkConfig : NSObject

/// 接口路径
@property (nonatomic, copy) NSString *urlPath;
/// 请求方法类型，默认get
@property (nonatomic, assign) AOCHTTPMethodType methodType;
/// 请求序列化类型，默认json
@property (nonatomic, assign) AOCRequestSerializerType requestType;
/// 响应序列化类型，默认json
@property (nonatomic, assign) AOCResponseSerializerType responseType;
/// 请求头
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *headers;

/// 默认配置
@property (nonatomic, strong, readonly, class) AOCNetworkConfig *defaultConfig;

/// 初始化配置
/// @param urlPath 接口路径
- (instancetype)initWithUrlPath:(NSString *)urlPath;

/// 初始化配置
/// @param urlPath 接口路径
/// @param methodType 请求方法类型
- (instancetype)initWithUrlPath:(NSString *)urlPath
                     methodType:(AOCHTTPMethodType)methodType;

/// 初始化配置
/// @param urlPath 接口路径
/// @param methodType 请求方法类型
/// @param requestType 请求序列化类型
- (instancetype)initWithUrlPath:(NSString *)urlPath
                     methodType:(AOCHTTPMethodType)methodType
                    requestType:(AOCRequestSerializerType)requestType;

/// 初始化配置
/// @param urlPath 接口路径
/// @param methodType 请求方法类型
/// @param requestType 请求序列化类型
/// @param responseType 响应序列化类型
- (instancetype)initWithUrlPath:(NSString *)urlPath
                     methodType:(AOCHTTPMethodType)methodType
                    requestType:(AOCRequestSerializerType)requestType
                   responseType:(AOCResponseSerializerType)responseType;

@end

NS_ASSUME_NONNULL_END
