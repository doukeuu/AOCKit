//
//  AOCCacheConfig.h
//  AOCKit
//
//  Created by pan on 2021/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Image Cache Expire Type
typedef NS_ENUM(NSUInteger, AOCCacheConfigExpireType) {
    /**
     * When the image cache is accessed it will update this value
     */
    AOCCacheConfigExpireTypeAccessDate,
    /**
     * When the image cache is created or modified it will update this value (Default)
     */
    AOCCacheConfigExpireTypeModificationDate,
    /**
     * When the image cache is created it will update this value
     */
    AOCCacheConfigExpireTypeCreationDate,
    /**
     * When the image cache is created, modified, renamed, file attribute updated (like permission, xattr)  it will update this value
     */
    AOCCacheConfigExpireTypeChangeDate,
};

@interface AOCCacheConfig : NSObject <NSCopying>

/**
 Gets the default cache config used for shared instance or initialization when it does not provide any cache config. Such as `AOCFile.sharedImageCache`.
 @note You can modify the property on default cache config, which can be used for later created cache instance. The already created cache instance does not get affected.
 */
@property (nonatomic, class, readonly, nonnull) AOCCacheConfig *defaultConfig;

/**
 * Whether or not to disable iCloud backup
 * Defaults to YES.
 */
@property (assign, nonatomic) BOOL shouldDisableiCloud;


/**
 * Whether or not to remove the expired disk data when application entering the background. (Not works for macOS)
 * Defaults to YES.
 */
@property (assign, nonatomic) BOOL shouldRemoveExpiredDataWhenEnterBackground;

/**
 * The reading options while reading cache from disk.
 * Defaults to 0. You can set this to `NSDataReadingMappedIfSafe` to improve performance.
 */
@property (assign, nonatomic) NSDataReadingOptions diskCacheReadingOptions;

/**
 * The writing options while writing cache to disk.
 * Defaults to `NSDataWritingAtomic`. You can set this to `NSDataWritingWithoutOverwriting` to prevent overwriting an existing file.
 */
@property (assign, nonatomic) NSDataWritingOptions diskCacheWritingOptions;

/**
 * The maximum length of time to keep an image in the disk cache, in seconds.
 * Setting this to a negative value means no expiring.
 * Setting this to zero means that all cached files would be removed when do expiration check.
 * Defaults to 1 week.
 */
@property (assign, nonatomic) NSTimeInterval maxDiskAge;

/**
 * The maximum size of the disk cache, in bytes.
 * Defaults to 0. Which means there is no cache size limit.
 */
@property (assign, nonatomic) NSUInteger maxDiskSize;

/*
 * The attribute which the clear cache will be checked against when clearing the disk cache
 * Default is Modified Date
 */
@property (assign, nonatomic) AOCCacheConfigExpireType diskCacheExpireType;

/**
 * The custom file manager for disk cache. Pass nil to let disk cache choose the proper file manager.
 * Defaults to nil.
 * @note This value does not support dynamic changes. Which means further modification on this value after cache initialized has no effect.
 * @note Since `NSFileManager` does not support `NSCopying`. We just pass this by reference during copying. So it's not recommend to set this value on `defaultCacheConfig`.
 */
@property (strong, nonatomic, nullable) NSFileManager *fileManager;

@end

NS_ASSUME_NONNULL_END
