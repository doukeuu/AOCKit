//
//  AOCNormalTableCell.h
//  AFNetworking
//
//  Created by ssbm on 2021/6/9.
//

#import "AOCTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface AOCNormalTableCell : AOCTableViewCell

/// 容器视图
@property (nonatomic, strong) UIView *containerView;
/// 标题标签
@property (nonatomic, strong) UILabel *titleLabel;
/// 内容标签
@property (nonatomic, strong) UILabel *contentLabel;
/// 是否显示箭头
@property (nonatomic, assign) BOOL showIndicator;
/// 是否显示分割线
@property (nonatomic, assign) BOOL showLine;
/// 分割线内边距
@property (nonatomic, assign) UIEdgeInsets lineInset;
/// 内容标签右边距
@property (nonatomic, assign) CGFloat contentRightMargin;
@end

NS_ASSUME_NONNULL_END
