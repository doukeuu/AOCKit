//
//  AOCNetworkManager.h
//  AOCKit
//
//  Created by ssbm on 2021/5/8.
//

#import <Foundation/Foundation.h>
#import "AOCNetworkConfig.h"

NS_ASSUME_NONNULL_BEGIN

/// 成功回调
typedef void (^AOCSuccessBlock)(NSURLSessionDataTask *task, id _Nullable responseObject);
/// 失败回调
typedef void (^AOCFailureBlock)(NSURLSessionDataTask * _Nullable task, NSError *error);


@interface AOCNetworkManager : NSObject

+ (instancetype)shareManager;
+ (instancetype)new  NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/// 网络请求方法
/// @param config 请求设置
/// @param param 参数字典
/// @param success 成功回调
/// @param failure 失败回调
- (nullable NSURLSessionDataTask *)taskWithConfig:(AOCNetworkConfig *)config
                                            param:(nullable NSDictionary *)param
                                          success:(nullable AOCSuccessBlock)success
                                          failure:(nullable AOCFailureBlock)failure;

/// 上传文件POST网络请求
/// @param config 请求config
/// @param param 参数字典
/// @param content 上传的内容字典，key作为name时，value只能是单个的image/data/filePath；
/// key不作为name时，value可以为数组，数组内容可以为image/data/filePath其中的一类
/// @param success 成功回调
/// @param failure 失败回调
- (nullable NSURLSessionDataTask *)uploadWithConfig:(AOCNetworkConfig *)config
                                              param:(nullable NSDictionary *)param
                                            content:(NSDictionary *)content
                                            success:(nullable AOCSuccessBlock)success
                                            failure:(nullable AOCFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
