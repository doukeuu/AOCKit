//
//  AOCTextFieldTableCell.h
//  AOCKit
//
//  Created by ssbm on 2021/6/9.
//

#import "AOCTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AOCTextFieldTableCellDelegate;

@interface AOCTextFieldTableCell : AOCTableViewCell

/// 输入框
@property (nonatomic, strong, readonly) UITextField *inputField;
/// 标题标签
@property (nonatomic, strong, readonly) UILabel *titleLabel;
/// 操作按钮
@property (nonatomic, strong, readonly) UIButton *actionButton;
/// 边框视图
@property (nonatomic, strong, readonly) UIView *bezelView;

/// 下标
@property (nonatomic, strong) NSIndexPath *indexPath;
/// 限制输入数量
@property (nonatomic, assign) NSInteger limitNumber;
/// 代理
@property (nonatomic, weak) id<AOCTextFieldTableCellDelegate> delegate;
@end


@protocol AOCTextFieldTableCellDelegate <NSObject>

@optional
/// 输入响应代理方法，text：输入的字符串，indexPath：单元格下标
- (void)textFieldTableCell:(AOCTextFieldTableCell *)cell didInput:(NSString *)text atIndex:(NSIndexPath *)indexPath;

/// 点击按钮响应方法，indexPath：单元格下标
- (void)textFieldTableCell:(AOCTextFieldTableCell *)cell didClickAt:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
