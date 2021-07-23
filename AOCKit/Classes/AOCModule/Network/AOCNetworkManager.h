//
//  AOCNetworkManager.h
//  AOCKit
//
//  Created by ssbm on 2021/5/8.
//

#import <Foundation/Foundation.h>
#import "AOCNetworkConfig.h"
#import "AOCNetworkConstant.h"

NS_ASSUME_NONNULL_BEGIN

/// 成功回调
typedef void (^AOCSuccessBlock)(id _Nullable result);
/// 失败回调
typedef void (^AOCFailureBlock)(NSDictionary<NSErrorUserInfoKey, id> *userInfo);


@interface AOCNetworkManager : NSObject

+ (instancetype)shareManager;
+ (instancetype)new  NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/// 设置网络请求baseURL
+ (void)resetSessionManagerBaseURL:(NSString *)baseURLString;

/// get请求
+ (void)GET:(AOCNetworkConfig *)config
      param:(nullable NSDictionary *)param
    success:(nullable AOCSuccessBlock)success
    failure:(nullable AOCFailureBlock)failure;

/// post请求
+ (void)POST:(AOCNetworkConfig *)config
       param:(nullable NSDictionary *)param
     success:(nullable AOCSuccessBlock)success
     failure:(nullable AOCFailureBlock)failure;

/// put请求
+ (void)PUT:(AOCNetworkConfig *)config
      param:(nullable NSDictionary *)param
    success:(nullable AOCSuccessBlock)success
    failure:(nullable AOCFailureBlock)failure;

/// patch请求
+ (void)PATCH:(AOCNetworkConfig *)config
        param:(nullable NSDictionary *)param
      success:(nullable AOCSuccessBlock)success
      failure:(nullable AOCFailureBlock)failure;

/// delete请求
+ (void)DELETE:(AOCNetworkConfig *)config
         param:(nullable NSDictionary *)param
       success:(nullable AOCSuccessBlock)success
       failure:(nullable AOCFailureBlock)failure;

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
+ (void)UPLOAD:(AOCNetworkConfig *)config
         param:(nullable NSDictionary *)param
       content:(NSDictionary *)content
       success:(nullable AOCSuccessBlock)success
       failure:(nullable AOCFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
