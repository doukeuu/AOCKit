//
//  AOCTextFieldTableCell.h
//  AOCKit
//
//  Created by ssbm on 2021/6/9.
//

#import "AOCTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AOCTextFieldTableCellType) {
    /// 左边有手机图标样式
    AOCTextFieldTableLeftPhone,
    /// 左边有账号图标样式
    AOCTextFieldTableLeftAccount,
    /// 左边图标，右边密码样式
    AOCTextFieldTableLeftRight,
    /// 区号样式
    AOCTextFieldTableAreaCode,
    /// 验证码样式
    AOCTextFieldTableVerifing,
    /// 密码样式
    AOCTextFieldTablePassword
};

@class AOCTextFieldTableCell;

@protocol AOCTextFieldTableCellDelegate <NSObject>

/// 输入响应代理方法，text：输入的字符串，indexPath：单元格下标
- (void)loginInputCell:(AOCTextFieldTableCell *)cell didInput:(NSString *)text atIndex:(NSIndexPath *)indexPath;

@optional
/// 点击按钮响应方法，indexPath：单元格下标
- (void)loginInputCell:(AOCTextFieldTableCell *)cell didClickAt:(NSIndexPath *)indexPath;
@end

@interface AOCTextFieldTableCell : AOCTableViewCell

/// 下标
@property (nonatomic, strong) NSIndexPath *indexPath;
/// 容器视图
@property (nonatomic, strong) UIView *containerView;
/// 输入框
@property (nonatomic, strong) UITextField *inputField;
/// 分割线
@property (nonatomic, strong) UIView *lineView;
/// 子视图样式
@property (nonatomic, assign) AOCTextFieldTableCellType multitype;
/// 占位符
@property (nonatomic, copy) NSString *placeholderText;
/// 按钮标题
@property (nonatomic, copy) NSString *buttonTitle;
/// 代理
@property (nonatomic, weak) id<AOCTextFieldTableCellDelegate> delegate;

/// 开始倒计时
- (void)beginTimeCountDown;
@end

NS_ASSUME_NONNULL_END
