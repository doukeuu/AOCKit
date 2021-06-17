//
//  AOCTableViewCell.m
//  AOCKit
//
//  Created by ssbm on 2021/5/7.
//

#import "AOCTableViewCell.h"
#import "AOCDefineColor.h"

@implementation AOCTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kCOLOR_fff;
    }
    return self;
}

@end
