//
//  AOCTableView.m
//  AOCKit
//
//  Created by ssbm on 2021/6/9.
//

#import "AOCTableView.h"
#import "AOCDefineColor.h"

@implementation AOCTableView

+ (instancetype)defaultGrouped {
    AOCTableView *tableView = [[AOCTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = kCOLOR_fff;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableView;
}

+ (instancetype)defaultPlain {
    AOCTableView *tableView = [[AOCTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = kCOLOR_fff;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableView;
}

@end
