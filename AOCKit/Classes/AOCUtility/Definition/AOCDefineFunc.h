//
//  AOCDefineFunc.h
//  AOCKit
//
//  Created by ssbm on 2021/4/27.
//

#ifndef AOCDefineFunc_h
#define AOCDefineFunc_h


// 打印信息及其所在类、方法和行号
#ifdef DEBUG
#define AOCLog(fmt, ...)  NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define AOCLog(...)
#endif


#endif /* AOCDefineFunc_h */
