//
//  AOCCacheConfig.m
//  AOCKit
//
//  Created by pan on 2021/12/2.
//

#import "AOCCacheConfig.h"

static const NSInteger kAOCCacheConfigMaxDiskAge = 60 * 60 * 24 * 7; // 1 week

@implementation AOCCacheConfig

+ (AOCCacheConfig *)defaultConfig {
    static dispatch_once_t onceToken;
    static AOCCacheConfig *_defaultConfig;
    dispatch_once(&onceToken, ^{
        _defaultConfig = [AOCCacheConfig new];
    });
    return _defaultConfig;
}

- (instancetype)init {
    if (self = [super init]) {
        _shouldDisableiCloud = YES;
        _shouldRemoveExpiredDataWhenEnterBackground = YES;
        _diskCacheReadingOptions = 0;
        _diskCacheWritingOptions = NSDataWritingAtomic;
        _maxDiskAge = kAOCCacheConfigMaxDiskAge;
        _maxDiskSize = 0;
        _diskCacheExpireType = AOCCacheConfigExpireTypeModificationDate;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    AOCCacheConfig *config = [[[self class] allocWithZone:zone] init];
    config.shouldDisableiCloud = self.shouldDisableiCloud;
    config.shouldRemoveExpiredDataWhenEnterBackground = self.shouldRemoveExpiredDataWhenEnterBackground;
    config.diskCacheReadingOptions = self.diskCacheReadingOptions;
    config.diskCacheWritingOptions = self.diskCacheWritingOptions;
    config.maxDiskAge = self.maxDiskAge;
    config.maxDiskSize = self.maxDiskSize;
    config.diskCacheExpireType = self.diskCacheExpireType;
    config.fileManager = self.fileManager; // NSFileManager does not conform to NSCopying, just pass the reference
    return config;
}


@end
