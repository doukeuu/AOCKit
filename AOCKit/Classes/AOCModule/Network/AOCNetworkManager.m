//
//  AOCNetworkManager.m
//  AOCKit
//
//  Created by ssbm on 2021/5/8.
//

#import "AOCNetworkManager.h"
#import "AOCDevice.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface AOCNetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *afManager;
@property (nonatomic, strong) NSString *userToken;
@end

@implementation AOCNetworkManager

+ (instancetype)shareManager {
    static AOCNetworkManager *networkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[AOCNetworkManager alloc] init];
    });
    return networkManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _afManager = [AFHTTPSessionManager manager];
        [self commonInitialize];
    }
    return self;
}

#pragma mark - Initialization

// 初始化
- (void)commonInitialize {
    NSURL *url = [NSURL URLWithString:[apiUrlString copy]];
    [self.afManager setValue:url forKey:@"_baseURL"];

    [self configureRequestSerializer];
    [self configureResponseSerializer];
    [self startNetworkReachabilityMonitoring];
}

// 配置请求序列化属性
- (void)configureRequestSerializer {
    self.afManager.requestSerializer.timeoutInterval = 20.f;
    NSString *userAgent = [self userAgentForRequestHeader];
    [self.afManager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
}

// 配置响应序列化属性
- (void)configureResponseSerializer {
    NSMutableSet *mutableSet = [self.afManager.responseSerializer.acceptableContentTypes mutableCopy];
    [mutableSet addObject:@"text/html"];
    [mutableSet addObject:@"text/xml"];
    [mutableSet addObject:@"text/plain"];
    self.afManager.responseSerializer.acceptableContentTypes = [mutableSet copy];
}

// 拼接请求的header的User-Agent
- (NSString *)userAgentForRequestHeader {
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = info[@"CFBundleDisplayName"];
    NSString *appVersion = info[@"CFBundleShortVersionString"];
    NSString *platform = [[UIDevice currentDevice] systemName];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *deviceName = AOCDevice.deviceName;
    NSString *agentString = [NSString stringWithFormat:@"%@/%@(%@;%@;%@)",
                             appName, appVersion, platform, systemVersion, deviceName];
    NSCharacterSet * set = [NSCharacterSet URLQueryAllowedCharacterSet];
    return [agentString stringByAddingPercentEncodingWithAllowedCharacters:set];
}

// 网络情况监听
- (void)startNetworkReachabilityMonitoring {
    //当使用AF发送网络请求时,只要有网络操作,那么在状态栏(电池条)wifi符号旁边显示  菊花提示
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [self.afManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"Network - 未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"Network - 网络未连接");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"Network - WiFi");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"Network - 2G、3G、4G");
                break;
        }
    }];
    [self.afManager.reachabilityManager startMonitoring];
    
    //网络活动发生变化时,会发送下方key 的通知,可以在通知中心中添加检测
    //AFNetworkingReachabilityDidChangeNotification
}

#pragma mark - Setter Configure

// 设置网络请求baseURL
+ (void)resetSessionManagerBaseURL:(NSString *)baseURLString {
    if (!baseURLString) return;
    NSURL *url = [NSURL URLWithString:baseURLString];
    [[AOCNetworkManager shareManager].afManager setValue:url forKey:@"_baseURL"];
}

#pragma mark - Request

// get请求
+ (void)GET:(AOCNetworkConfig *)config param:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure {
    config.methodType = AOCHTTPMethodGET;
    [[AOCNetworkManager shareManager] taskWithConfig:config param:param success:success failure:failure];
}

// post请求
+ (void)POST:(AOCNetworkConfig *)config param:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure {
    config.methodType = AOCHTTPMethodPOST;
    [[AOCNetworkManager shareManager] taskWithConfig:config param:param success:success failure:failure];
}

// put请求
+ (void)PUT:(AOCNetworkConfig *)config param:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure {
    config.methodType = AOCHTTPMethodPUT;
    [[AOCNetworkManager shareManager] taskWithConfig:config param:param success:success failure:failure];
}

// patch请求
+ (void)PATCH:(AOCNetworkConfig *)config param:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure {
    config.methodType = AOCHTTPMethodPATCH;
    [[AOCNetworkManager shareManager] taskWithConfig:config param:param success:success failure:failure];
}

// delete请求
+ (void)DELETE:(AOCNetworkConfig *)config param:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure {
    config.methodType = AOCHTTPMethodDELETE;
    [[AOCNetworkManager shareManager] taskWithConfig:config param:param success:success failure:failure];
}

// 网络请求方法
- (NSURLSessionDataTask *)taskWithConfig:(AOCNetworkConfig *)config param:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure {
    // 参数序列化方式
    [self configRequestSerializerType:config.requestType];
    // 响应序列化方式
    [self configResponseSerializerType:config.responseType];
    
    NSURLSessionDataTask *task;
    NSString *method = [self methodNameWithType:config.methodType];
    task = [self.afManager dataTaskWithHTTPMethod:method
                                        URLString:config.urlPath
                                       parameters:param
                                          headers:config.headers
                                   uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccess:responseObject task:task block:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFailure:error task:task block:failure];
    }];
    [task resume];
    [self querySameRequest:task cancelNew:YES];
    return task;
}

// 上传文件POST网络请求
+ (void)UPLOAD:(AOCNetworkConfig *)config param:(NSDictionary *)param content:(NSDictionary *)content success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    AOCNetworkManager *manager = [AOCNetworkManager shareManager];
    // 参数序列化方式
    [manager configRequestSerializerType:config.requestType];
    // 响应序列化方式
    [manager configResponseSerializerType:config.responseType];
    
    NSURLSessionTask *task = [manager.afManager POST:config.urlPath
                                          parameters:param
                                             headers:config.headers
                           constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [self handleContent:content formData:formData];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [manager handleSuccess:responseObject task:task block:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [manager handleFailure:error task:task block:failure];
    }];
    [manager querySameRequest:task cancelNew:YES];
}

#pragma mark - Before Request

- (NSString *)methodNameWithType:(AOCHTTPMethodType)type {
    switch (type) {
        case AOCHTTPMethodGET:    return @"GET";
        case AOCHTTPMethodPOST:   return @"POST";
        case AOCHTTPMethodPUT:    return @"PUT";
        case AOCHTTPMethodPATCH:  return @"PATCH";
        case AOCHTTPMethodDELETE: return @"DELETE";
        default:                  return @"GET";
    }
}

// 参数序列化方式设置
- (void)configRequestSerializerType:(AOCRequestSerializerType)type {
    if (type == AOCRequestSerializerTypeJSON) {
        self.afManager.requestSerializer = [AFJSONRequestSerializer serializer];
    } else {
        self.afManager.requestSerializer = [AFPropertyListRequestSerializer serializer];
    }
    [self configureRequestSerializer];
}

// 响应序列化方式设置
- (void)configResponseSerializerType:(AOCResponseSerializerType)type {
    if (type == AOCResponseSerializerTypeJSON) {
        self.afManager.responseSerializer = [AFJSONResponseSerializer serializer];
    } else if (type == AOCResponseSerializerTypeHTTP) {
        self.afManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    } else {
        self.afManager.responseSerializer = [AFCompoundResponseSerializer serializer];
    }
    [self configureResponseSerializer];
}

// 处理上传文件的添加
+ (void)handleContent:(NSDictionary *)content formData:(id<AFMultipartFormData>)formData {
    if (!content || content.count == 0) return ;

    NSArray *array = content.allKeys;
    id firstObject = content.allValues.firstObject; // 默认内容字典里面每个key都是name，与value值一一对应
    BOOL isArray = NO;
    if ([firstObject isKindOfClass:[NSArray class]]) { // 内容字典value值为数组时，按字典仅有一个值处理
        array = (NSArray *)firstObject;
        isArray = YES;
    }

    for (NSInteger i = 0; i < array.count; i ++) {
        id key = nil, value = nil;
        if (isArray) {
            value = [array objectAtIndex:i];
        } else {
            key = [array objectAtIndex:i];
            value = [content objectForKey:key];
        }
        NSString *name = [NSString stringWithFormat:@"%zd", i];

        if ([value isKindOfClass:[UIImage class]]) { // 内容值为图片
            NSData *imageData = UIImageJPEGRepresentation(value, 1);
            NSString *type = @"jpg";
            if (!imageData) {
                imageData = UIImagePNGRepresentation(value);
                type = @"png";
            }
            if (key) {
                NSString *fileName = [NSString stringWithFormat:@"%zd.%@", i, type];
                NSString *mimeType = [NSString stringWithFormat:@"image/%@", type];
                [formData appendPartWithFileData:imageData name:key fileName:fileName mimeType:mimeType];
            } else {
                [formData appendPartWithFormData:imageData name:name];
            }
        } else if ([value isKindOfClass:[NSString class]]) { // 内容值为文件地址
            NSURL *fileURL = [NSURL URLWithString:value];
            if ([fileURL isFileURL]) {
                [formData appendPartWithFileURL:fileURL name:name error:nil];
            }
        }else if ([value isKindOfClass:[NSData class]]) { // 内容值为NSData数据
            [formData appendPartWithFormData:value name:name];
        }
    }
}

#pragma mark - After Response

// 处理成功返回结果
- (void)handleSuccess:(id)responseObject task:(NSURLSessionDataTask *)task block:(SuccessBlock)block {
    //  返回头中有token值，则缓存
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSString *token = response.allHeaderFields[@"USER_TOKEN"];
    if (token.length == 0) return;
    self.userToken = token;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"USER_TOKEN"];
    });
    
    // 返回体中的信息处理
    NSString *status = [responseObject objectForKey:@"status"];
    if (status && [status isEqualToString:@"200"]) {
        id data = [responseObject objectForKey:@"data"];
        if (block) block(data);

    } else {
        id message = [responseObject objectForKey:@"message"];
        if ([message isKindOfClass:[NSDictionary class]]) {
            NSString *msg = [message valueForKey:@"msg"];
            NSLog(@"Error 400 = %@", msg);
        } else if ([message isKindOfClass:[NSString class]]) {
            NSLog(@"Error 400 = %@", message);
        } else {
            NSLog(@"Error 400 = %@", message);
        }
        NSDictionary *errorInfo = @{NSDebugDescriptionErrorKey: @"返回 status != 200 错误"};
        NSError *statusErr = [NSError errorWithDomain:NSURLErrorDomain
                                                 code:NSURLErrorBadServerResponse
                                             userInfo:errorInfo];
        if (block) block(statusErr);
    }
}

- (void)handleFailure:(NSError *)error task:(NSURLSessionDataTask *)task block:(FailureBlock)block {
    NSLog(@"-- %@", error);
    if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == -999) {
        return; // 网络请求被取消
    }
    NSInteger statusCode = [(NSHTTPURLResponse *)task.response statusCode];
    NSError *underlyingError = error;
    if (error.userInfo[NSUnderlyingErrorKey]) {
        underlyingError = error.userInfo[NSUnderlyingErrorKey];
    }
    NSData *errorData = underlyingError.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    NSString *tips = [[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding];
    
    if (statusCode == 401) {
        NSString *string = tips ?: @"即将退出登陆";
        tips = @"";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:UUNetworkResponseStatusCode401 object:nil userInfo:@{UUNetworkErrorTips: string}];
        });
    } else if (statusCode == 404) {
        tips = @"温馨提示：数据走丢了！";
    } else {
        tips = tips ?: @"未找到错误信息";
    }
    NSMutableDictionary *userInfo = [underlyingError.userInfo mutableCopy];
//    [userInfo setObject:tips forKey:UUNetworkErrorTips];
//    [userInfo setObject:@(statusCode) forKey:UUNetworkErrorCode];
    if (block) block([userInfo copy]);
}

#pragma mark - Utility

// 查询当前正在运行的task，停止相同的task
- (void)querySameRequest:(NSURLSessionTask *)newTask cancelNew:(BOOL)cancelNew {
    NSMutableArray *oldTasks = [[AOCNetworkManager shareManager].afManager.tasks mutableCopy];
    if (oldTasks.count > 0) {
        [oldTasks removeLastObject];
    } else {
        return;
    }
    for (NSURLSessionTask *oldTask in oldTasks) {
        if ([self compareEqualRequest:newTask.originalRequest to:oldTask.originalRequest]) {
            cancelNew ? [newTask cancel] : [oldTask cancel];
            if (cancelNew) break;
        }
    }
}

// 比较两个NSURLRequest是否相等
- (BOOL)compareEqualRequest:(NSURLRequest *)compare to:(NSURLRequest *)toValue {
    BOOL sameMethod = [compare.HTTPMethod isEqualToString:toValue.HTTPMethod];
    BOOL sameURL = [compare.URL.absoluteString isEqualToString:toValue.URL.absoluteString];
    if (sameMethod && sameURL) {
        if ([compare.HTTPMethod isEqualToString:@"GET"] ||
            [compare.HTTPMethod isEqualToString:@"HEAD"] ||
            [compare.HTTPMethod isEqualToString:@"DELETE"]) {
            return YES;
        } else if ([compare.HTTPBody isEqualToData:toValue.HTTPBody]) {
            return YES;
        }
    }
    return NO;
}

@end
