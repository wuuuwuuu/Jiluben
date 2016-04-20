//
//  JLTextFieldCell.m
//  Jiluben
//
//  Created by Yue Wu on 4/13/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import "JLTextFieldCell.h"

@interface JLTextFieldCell ()

@end

@implementation JLTextFieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    // Single Text field
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
    //    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    self.textField.clipsToBounds = NO;
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.textField];
}

- (NSString*)text {
    return self.textField.text;
}

@end
