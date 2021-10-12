//
//  AOCFileConfig.m
//  AOCKit
//
//  Created by pan on 2021/9/25.
//

#import "AOCFileConfig.h"

static const NSInteger kAOCFileConfigMaxDiskAge = 60 * 60 * 24 * 7; // 1 week

@implementation AOCFileConfig

+ (AOCFileConfig *)defaultConfig {
    static dispatch_once_t onceToken;
    static AOCFileConfig *_defaultConfig;
    dispatch_once(&onceToken, ^{
        _defaultConfig = [AOCFileConfig new];
    });
    return _defaultConfig;
}

- (instancetype)init {
    if (self = [super init]) {
        _shouldDisableiCloud = YES;
        _shouldRemoveExpiredDataWhenEnterBackground = YES;
        _diskCacheReadingOptions = 0;
        _diskCacheWritingOptions = NSDataWritingAtomic;
        _maxDiskAge = kAOCFileConfigMaxDiskAge;
        _maxDiskSize = 0;
        _diskCacheExpireType = AOCFileConfigExpireTypeModificationDate;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    AOCFileConfig *config = [[[self class] allocWithZone:zone] init];
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
