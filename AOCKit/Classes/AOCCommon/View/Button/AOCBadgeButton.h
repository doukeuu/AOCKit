//
//  AOCBadgeButton.h
//  AOCKit
//
//  Created by ssbm on 2021/10/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCBadgeButton : UIButton

@property (nonatomic, copy) NSString *badgeValue;            // 角标值
@property (nonatomic, strong) UIImage *badgeImage;           // 角标图片
@property (nonatomic, assign) CGFloat badgeMinSize;          // 角标最小尺寸
@property (nonatomic, strong, readonly) UILabel *badgeLabel; // 角标标签
@end

NS_ASSUME_NONNULL_END
