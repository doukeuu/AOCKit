//
//  AOCNetworkManager.m
//  AOCKit
//
//  Created by ssbm on 2021/5/8.
//

#import "AOCNetworkManager.h"
#import "AOCDevice.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

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

#pragma mark - Request

// 网络请求方法
- (NSURLSessionDataTask *)taskWithConfig:(AOCNetworkConfig *)config
                                   param:(NSDictionary *)param
                                 success:(AOCSuccessBlock)success
                                 failure:(AOCFailureBlock)failure {
    // 参数序列化方式
    [self configRequestSerializerType:config.requestType];
    // 响应序列化方式
    [self configResponseSerializerType:config.responseType];
    
    NSURLSessionDataTask *task;
    task = [self.afManager dataTaskWithHTTPMethod:config.methodName
                                        URLString:config.urlPath
                                       parameters:param
                                          headers:config.headers
                                   uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:success failure:failure];
    [task resume];
    [self querySameRequest:task cancelNew:YES];
    return task;
}

// 上传文件POST网络请求
- (NSURLSessionDataTask *)uploadWithConfig:(AOCNetworkConfig *)config
                                     param:(NSDictionary *)param
                                   content:(NSDictionary *)content
                                   success:(AOCSuccessBlock)success
                                   failure:(AOCFailureBlock)failure {
    
    // 参数序列化方式
    [self configRequestSerializerType:config.requestType];
    // 响应序列化方式
    [self configResponseSerializerType:config.responseType];
    
    NSURLSessionDataTask *task = [self.afManager POST:config.urlPath
                                           parameters:param
                                              headers:config.headers
                            constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [self handleContent:content formData:formData];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:success failure:failure];
    [self querySameRequest:task cancelNew:YES];
    return task;
}

#pragma mark - Before Request

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
- (void)handleContent:(NSDictionary *)content formData:(id<AFMultipartFormData>)formData {
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
