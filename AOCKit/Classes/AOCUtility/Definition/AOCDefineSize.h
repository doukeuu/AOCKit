//
//  AOCDefineSize.h
//  AOCKit
//
//  Created by ssbm on 2021/4/29.
//

#ifndef AOCDefineSize_h
#define AOCDefineSize_h


#pragma mark - System

// 屏幕宽、高
#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds
#define SCREEN_SIZE    [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

// 状态条、导航条、TabBar高度
#define STATUS_HEIGHT     (UIApplication.sharedApplication.statusBarFrame.size.height)
#define NAVIGATION_H      (STATUS_HEIGHT + 44.0)
#define TAB_BAR_HEIGHT    (BOTTOM_SAFE_AREA + 49.0)
#define BOTTOM_SAFE_AREA  (STATUS_HEIGHT > 20.0 ? 34.0 : 0.0)


#pragma mark - Custom

// 适配尺寸
#define kSCREEN_RATIO       (SCREEN_WIDTH / 375.0)
#define kSCREEN_FIT_W(x)    (SCREEN_WIDTH / 375.0 * (x))
#define kSCREEN_FIT_H(x)    (SCREEN_HEIGHT / 667.0 * (x))




#endif /* AOCDefineSize_h */
