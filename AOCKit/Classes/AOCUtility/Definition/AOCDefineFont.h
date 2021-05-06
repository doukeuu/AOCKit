//
//  AOCDefineFont.h
//  AOCKit
//
//  Created by ssbm on 2021/4/29.
//

#ifndef AOCDefineFont_h
#define AOCDefineFont_h


#pragma mark - Configure

// 自定义系统字体大小
#define FONT(s)            [UIFont systemFontOfSize:(s)]
#define FONT_BOLD(s)       [UIFont boldSystemFontOfSize:(s)]
#define FONT_WEIGHT(s, w)  [UIFont systemFontOfSize:(s) weight:(w)]


#pragma mark - Custom

// 导航栏字体大小
#define kFONT_NAV_TITLE    FONT(18)
// TabBar字体大小
#define kFONT_TAB_TITLE    FONT(11)


#endif /* AOCDefineFont_h */
