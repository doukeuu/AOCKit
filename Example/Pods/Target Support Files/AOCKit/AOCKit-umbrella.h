#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AOCBaseController.h"
#import "AOCCollectionController.h"
#import "AOCNavigationController.h"
#import "AOCTabBarController.h"
#import "AOCTableController.h"
#import "AOCWebController.h"
#import "NSBundle+AOC.h"
#import "UIImage+AOC.h"
#import "AOCConstantKey.h"
#import "AOCDefineColor.h"
#import "AOCDefineFont.h"
#import "AOCDefineFunc.h"
#import "AOCDefineKey.h"
#import "AOCDefineSize.h"
#import "AOCEnumeration.h"

FOUNDATION_EXPORT double AOCKitVersionNumber;
FOUNDATION_EXPORT const unsigned char AOCKitVersionString[];

