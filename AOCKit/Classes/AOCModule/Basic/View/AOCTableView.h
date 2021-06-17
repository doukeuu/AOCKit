//
//  AOCTableView.h
//  AOCKit
//
//  Created by ssbm on 2021/6/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AOCTableView : UITableView

+ (instancetype)defaultGrouped;

+ (instancetype)defaultPlain;
@end

NS_ASSUME_NONNULL_END
