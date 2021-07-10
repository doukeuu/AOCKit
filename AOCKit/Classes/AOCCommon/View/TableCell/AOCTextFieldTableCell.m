//
//  AOCTextFieldTableCell.m
//  AOCKit
//
//  Created by ssbm on 2021/6/9.
//

#import "AOCTextFieldTableCell.h"
#import "AOCDefineColor.h"
#import <Masonry/Masonry.h>

@interface AOCTextFieldTableCell () <UITextFieldDelegate>

@end

@implementation AOCTextFieldTableCell

@synthesize titleLabel   = _titleLabel;
@synthesize actionButton = _actionButton;
@synthesize bezelView    = _bezelView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _limitNumber = 1000;
        [self generateSubviews];
    }
    return self;
}

#pragma mark - Subviews

// 生成子视图
- (void)generateSubviews {
    // 输入框
    _inputField = [[UITextField alloc] init];
    _inputField.delegate = self;
    _inputField.font = [UIFont systemFontOfSize:16];
    _inputField.textColor = kCOLOR_333;
    _inputField.returnKeyType = UIReturnKeyDone;
    _inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.contentView addSubview:_inputField];
    [_inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(-1);
    }];
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputFieldDidChanged)
                                                 name:UITextFieldTextDidChangeNotification object:nil];
}

// 标题标签
- (UILabel *)titleLabel {
    if (_titleLabel) return _titleLabel;
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = kCOLOR_999;
    [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:_titleLabel];
    return _titleLabel;
}

// 操作按钮
- (UIButton *)actionButton {
    if (_actionButton) return _actionButton;
    _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _actionButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_actionButton setTitleColor:kCOLOR_333 forState:UIControlStateNormal];
    [_actionButton addTarget:self action:@selector(clickActionButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.actionButton];
    return _actionButton;
}

// 边框视图
- (UIView *)bezelView {
    if (!_bezelView) {
        _bezelView = [[UIView alloc] init];
        _bezelView.backgroundColor = kCOLOR_fff;
        [self.contentView insertSubview:_bezelView atIndex:0];
        [_bezelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _bezelView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_titleLabel) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(16);
        }];
    }
    
    if (_actionButton) {
        CGFloat width = _actionButton.intrinsicContentSize.width;
        width += 10;
        [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-16);
            make.width.mas_equalTo(width);
        }];
    }
    
    [self.inputField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        if (_titleLabel) {
            make.left.equalTo(self.titleLabel.mas_right);
        } else {
            make.left.mas_equalTo(16);
        }
        if (_actionButton) {
            make.right.equalTo(self.actionButton.mas_left);
        } else {
            make.right.mas_equalTo(-16);
        }
        make.bottom.mas_equalTo(-1);
    }];
}

#pragma mark - Respond

// 点击按钮响应
- (void)clickActionButton:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(textFieldTableCell:didClickAt:)]) {
        [self.delegate textFieldTableCell:self didClickAt:self.indexPath];
    }
}

// 字符串改变的通知响应
- (void)inputFieldDidChanged {
    if (!self.inputField.isFirstResponder) return;
    if (self.inputField.text.length > self.limitNumber) {
        self.inputField.text = [self.inputField.text substringToIndex:self.limitNumber];
    }
    [self handleInputedText:self.inputField.text]; // 为了输入字符串时，登陆按钮可点击
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self handleInputedText:textField.text];
}

// 处理输入的字符串
- (void)handleInputedText:(NSString *)text {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *input = [text stringByTrimmingCharactersInSet:set];
    if ([self.delegate respondsToSelector:@selector(textFieldTableCell:didInput:atIndex:)]) {
        [self.delegate textFieldTableCell:self didInput:input atIndex:self.indexPath];
    }
}

@end
