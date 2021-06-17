//
//  AOCTextFieldTableCell.m
//  AOCKit
//
//  Created by ssbm on 2021/6/9.
//

#import "AOCTextFieldTableCell.h"
#import "UIButton+AOC.h"
#import "AOCDefineColor.h"
#import <Masonry/Masonry.h>

@interface AOCTextFieldTableCell () <UITextFieldDelegate>
{
    CGFloat _animationY;
}
@property (nonatomic, strong) UILabel *titleLabel;    // 标题标签
@property (nonatomic, strong) UIButton *actionButton; // 操作按钮
@property (nonatomic, strong) UIImageView *leftIcon;  // 左边图标

@end

@implementation AOCTextFieldTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self generateSubviews];
    }
    return self;
}

#pragma mark - Subviews

// 生成子视图
- (void)generateSubviews {
    // 容器视图
    _containerView = [[UIView alloc] init];
    [self.contentView addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    // 标题标签
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = kCOLOR_999;
    _titleLabel.hidden = YES;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(30);
    }];
    
    // 输入框
    _inputField = [[UITextField alloc] init];
    _inputField.delegate = self;
    _inputField.font = [UIFont systemFontOfSize:16];
    _inputField.textColor = kCOLOR_333;
    _inputField.returnKeyType = UIReturnKeyDone;
    _inputField.placeholder = @" 123";
    _inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.contentView addSubview:_inputField];
    
    // 分割线
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = kCOLOR_LINE;
    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(1);
    }];
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputFieldDidChanged)
                                                 name:UITextFieldTextDidChangeNotification object:nil];
}

// 操作按钮
- (UIButton *)actionButton {
    if (_actionButton) return _actionButton;
    _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_actionButton addTarget:self action:@selector(clickActionButton:) forControlEvents:UIControlEventTouchUpInside];
    return _actionButton;
}

// 左边图标
- (UIImageView *)leftIcon {
    if (_leftIcon) return _leftIcon;
    _leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    _leftIcon.contentMode = UIViewContentModeTopLeft;
    self.inputField.leftView = _leftIcon;
    self.inputField.leftViewMode = UITextFieldViewModeAlways;
    return _leftIcon;
}

#pragma mark - Multitype

// 密码样式
- (void)multitypePassword {
    self.actionButton.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, -5);
    [self.actionButton setImage:[UIImage imageNamed:@"login_eye_close"] forState:UIControlStateNormal];
    [self.actionButton setImage:[UIImage imageNamed:@"login_eye_open"] forState:UIControlStateSelected];
    [self.contentView addSubview:self.actionButton];
    CGSize size = self.actionButton.intrinsicContentSize;
    size.width += 10;
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.inputField.mas_centerY);
        make.right.mas_equalTo(-30);
        make.size.mas_equalTo(size);
    }];
    
    self.inputField.secureTextEntry = YES;
    if (@available(iOS 10.0, *)) {
        self.inputField.textContentType = UITextContentTypeName;
    } else {
        // Fallback on earlier versions
    }
    [self configInputFieldLayoutWithRightView:self.actionButton];
}

// 区号样式
- (void)multitypeAreaCode {
    self.actionButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.actionButton.contentEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8);
    [self.actionButton setImage:[UIImage imageNamed:@"arrow_down_black"] forState:UIControlStateNormal];
    [self.actionButton setTitleColor:kCOLOR_333 forState:UIControlStateNormal];
    [self.actionButton setTitle:@"+ 86" forState:UIControlStateNormal];
    [self.actionButton resetImageTitlePosition:AOCButtonImageRightTitleLeft space:15];
    CGSize size = self.actionButton.intrinsicContentSize;
    size.width +=  20;
    self.actionButton.frame = CGRectMake(0, 0, size.width, size.height);
    self.inputField.leftView = self.actionButton;
    self.inputField.leftViewMode = UITextFieldViewModeAlways;
    self.inputField.keyboardType = UIKeyboardTypeNumberPad;
    [self configInputFieldLayoutWithRightView:nil];
}

// 验证码样式
- (void)multitypeVerifing {
    self.actionButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.actionButton.contentEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 0);
    [self.actionButton setTitleColor:COLOR_HEX(0xF5A623) forState:UIControlStateNormal];
    [self.actionButton setTitleColor:COLOR_HEX(0xF5A623) forState:UIControlStateDisabled];
    [self.actionButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.actionButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.contentView addSubview:self.actionButton];
    CGSize size = self.actionButton.intrinsicContentSize;
    size.width += 32;
    [self.actionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.inputField.mas_centerY);
        make.right.mas_equalTo(-30);
        make.size.mas_equalTo(size);
    }];
    self.inputField.keyboardType = UIKeyboardTypeNumberPad;
    [self configInputFieldLayoutWithRightView:self.actionButton];
}

// 设置输入框的约束
- (void)configInputFieldLayoutWithRightView:(UIView *)rightView {
    [self.inputField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.bottom.mas_equalTo(-1);
        if (rightView) {
            make.right.equalTo(rightView.mas_left).mas_offset(-10);
        } else {
            make.right.mas_equalTo(-30);
        }
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - Setter

// 设置样式
- (void)setMultitype:(AOCTextFieldTableCellType)multitype {
    _multitype = multitype;
    switch (_multitype) {
        case AOCTextFieldTableLeftPhone:
            [self configInputFieldLayoutWithRightView:nil];
            break;
        case AOCTextFieldTableLeftAccount:
            [self configInputFieldLayoutWithRightView:nil];
            break;
        case AOCTextFieldTableLeftRight:
            [self multitypePassword];
            self.leftIcon.image = [UIImage imageNamed:@"login_password_gray"];
            break;
        case AOCTextFieldTableAreaCode:
            [self multitypeAreaCode];
            break;
        case AOCTextFieldTableVerifing:
            [self multitypeVerifing];
            break;
        case AOCTextFieldTablePassword:
            [self multitypePassword];
            break;
    }
}

// 设置占位符
- (void)setPlaceholderText:(NSString *)placeholderText {
    _placeholderText = placeholderText;
    self.titleLabel.text = _placeholderText;
    NSDictionary *attribute = @{NSForegroundColorAttributeName: kCOLOR_999};
    self.inputField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_placeholderText attributes:attribute];
}

// 按钮标题
- (void)setButtonTitle:(NSString *)buttonTitle {
    _buttonTitle = [buttonTitle copy];
    [self.actionButton setTitle:_buttonTitle forState:UIControlStateNormal];
    if (self.multitype == AOCTextFieldTableAreaCode) {
        [self.actionButton resetImageTitlePosition:AOCButtonImageRightTitleLeft space:15];
    }
}

#pragma mark - Respond

// 点击按钮响应
- (void)clickActionButton:(UIButton *)button {
    if (self.multitype == AOCTextFieldTableLeftRight || self.multitype == AOCTextFieldTablePassword) {
        button.selected = !button.isSelected;
        self.inputField.secureTextEntry = !button.isSelected;
        return;
    }
    if (self.multitype == AOCTextFieldTableVerifing) {
        [self.inputField becomeFirstResponder];
    }
    if ([self.delegate respondsToSelector:@selector(loginInputCell:didClickAt:)]) {
        [self.delegate loginInputCell:self didClickAt:self.indexPath];
    }
}

// 字符串改变的通知响应
- (void)inputFieldDidChanged {
    if (!self.inputField.isFirstResponder) return;
    if (self.inputField.text.length > 20) {
        self.inputField.text = [self.inputField.text substringToIndex:20];
    }
    [self handleInputedText:self.inputField.text]; // 为了输入字符串时，登陆按钮可点击
}

// 处理输入的字符串
- (void)handleInputedText:(NSString *)text {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *input = [text stringByTrimmingCharactersInSet:set];
    if ([self.delegate respondsToSelector:@selector(loginInputCell:didInput:atIndex:)]) {
        [self.delegate loginInputCell:self didInput:input atIndex:self.indexPath];
    }
}

// 开始倒计时
- (void)beginTimeCountDown {
    __weak typeof(self) weakSelf = self;
    __block NSInteger totalTime = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        totalTime --;
        if (totalTime < 0 || !weakSelf) {
            dispatch_source_cancel(timer);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf configButtonStyleWithTime:totalTime];
        });
    });
    dispatch_resume(timer);
}

// 设置按钮样式
- (void)configButtonStyleWithTime:(NSInteger)time {
    if (time >= 0) {
        NSString *title = [NSString stringWithFormat:@"%zds后重新获取", time];
        [self.actionButton setTitle:title forState:UIControlStateNormal];
    } else {
        [self.actionButton setTitle:@"重新获取" forState:UIControlStateNormal];
    }
    self.actionButton.enabled = time < 0;
    self.actionButton.layer.borderColor = self.actionButton.enabled ? UIColor.redColor.CGColor : kCOLOR_999.CGColor;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self handleInputedText:textField.text];
}

@end
