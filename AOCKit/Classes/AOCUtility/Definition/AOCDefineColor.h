//
//  AOCDefineColor.h
//  AOCKit
//
//  Created by ssbm on 2021/4/29.
//

#ifndef AOCDefineColor_h
#define AOCDefineColor_h


#pragma mark - Configure

// 颜色设置
#define COLOR_RGB(r,g,b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define COLOR_RGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define COLOR_HEX(value)     [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 \
                                             green:((float)((value & 0xFF00) >> 8))/255.0    \
                                              blue:((float)(value & 0xFF))/255.0 alpha:1.0]


#pragma mark - Navigation

// 导航栏标题颜色
#define kCOLOR_NAV_TITLE    COLOR_HEX(0x333333)
// 导航栏背景色
#define kCOLOR_NAV_BACK     COLOR_RGBA(234, 234, 234, 0.93)
// 导航栏背景色
#define kCOLOR_NAV_LINE     COLOR_RGB(222, 222, 222)


#pragma mark - TabBar

// TabBar标题颜色normal
#define kCOLOR_TAB_TITLE_N    COLOR_HEX(0x333333)
// TabBar标题颜色selected
#define kCOLOR_TAB_TITLE_S    COLOR_HEX(0x333333)
// TabBar背景色
#define kCOLOR_TAB_BACK       COLOR_RGBA(234, 234, 234, 0.93)
// TabBar背景色
#define kCOLOR_TAB_LINE       COLOR_RGB(222, 222, 222)


#pragma mark - View

// 视图背景色
#define kCOLOR_VIEW_BG    COLOR_RGB(234, 234, 234);


#pragma mark - Color With Name

#define kCOLOR_000    COLOR_HEX(0x000000)
#define kCOLOR_333    COLOR_HEX(0x333333)
#define kCOLOR_666    COLOR_HEX(0x666666)
#define kCOLOR_999    COLOR_HEX(0x999999)
#define kCOLOR_fff    COLOR_HEX(0xffffff)


#endif /* AOCDefineColor_h */
