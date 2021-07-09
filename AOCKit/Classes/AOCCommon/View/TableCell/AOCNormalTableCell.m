//
//  AOCNormalTableCell.m
//  AFNetworking
//
//  Created by ssbm on 2021/6/9.
//

#import "AOCNormalTableCell.h"
#import "AOCDefineColor.h"
#import "UIImage+Kit.h"
#import <Masonry/Masonry.h>

@interface AOCNormalTableCell ()

@property (nonatomic, strong) UIImageView *indicatorView; // 箭头
@property (nonatomic, strong) UIView *lineView;           // 分割线

@end

@implementation AOCNormalTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _showLine = YES;
        _contentRightMargin = -15;
    }
    return self;
}

#pragma mark - Subviews

// 容器视图
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        [self.contentView addSubview:_containerView];
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _containerView;
}

// 标题标签
- (UILabel *)titleLabel {
    if (_titleLabel) return _titleLabel;
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = kCOLOR_999;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self.containerView addSubview:_titleLabel];
    return _titleLabel;
}

// 内容标签
- (UILabel *)contentLabel {
    if (_contentLabel) return _contentLabel;
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = kCOLOR_333;
    _contentLabel.font = [UIFont systemFontOfSize:16];
    [self.containerView addSubview:_contentLabel];
    return _contentLabel;
}

// 箭头
- (UIImageView *)indicatorView {
    if (_indicatorView) return _indicatorView;
    _indicatorView = [[UIImageView alloc] init];
    _indicatorView.image = [UIImage imageInBundleNamed:@"arrow_right_gray"];
    [self.containerView addSubview:_indicatorView];
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.width.height.mas_equalTo(15);
    }];
    return _indicatorView;
}

// 分割线
- (UIView *)lineView {
    if (_lineView) return _lineView;
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = kCOLOR_999;
    [self.containerView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    return _lineView;
}

#pragma mark - Setter

// 是否显示箭头
- (void)setShowIndicator:(BOOL)showIndicator {
    if (_showIndicator == showIndicator) return;
    _showIndicator = showIndicator;
    self.indicatorView.hidden = !_showIndicator;
}

// 是否显示分割线
- (void)setShowLine:(BOOL)showLine {
    if (_showLine == showLine) return;
    _showLine = showLine;
    self.lineView.hidden = !_showLine;
}

// 分割线内边距
- (void)setLineInset:(UIEdgeInsets)lineInset {
    _lineInset = lineInset;
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineInset.left);
        make.right.mas_equalTo(lineInset.right);
    }];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_titleLabel) {
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    if (_contentLabel) {
        [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (self->_titleLabel) {
                make.left.equalTo(self->_titleLabel.mas_right).offset(10);
            } else {
                make.left.mas_equalTo(15);
            }
            make.centerY.mas_equalTo(0);
            if (self->_indicatorView) {
                make.right.equalTo(self->_indicatorView.mas_left);
            } else {
                make.right.mas_equalTo(self.contentRightMargin);
            }
        }];
    }
}

@end
