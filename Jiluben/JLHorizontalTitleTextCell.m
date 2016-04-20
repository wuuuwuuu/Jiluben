//
//  JLHorizontalTitleTextCell.m
//  Jiluben
//
//  Created by Yue Wu on 4/11/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import "JLCons.h"
#import "JLHorizontalTitleTextCell.h"

@interface JLHorizontalTitleTextCell ()

//@property (nonatomic, strong) NSString* labelText;

@end

@implementation JLHorizontalTitleTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initUI];
        //        [self setLabelText:[label uppercaseString]];
    }
    return self;
}

- (void)initUI
{
    // Label.
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width/3.0, self.contentView.bounds.size.height)];
//    [self.label setFont:JLStyledTextFieldCell.fontForLabel];
    [self.label setTextColor:[UIColor blackColor]];
    [self.label setBackgroundColor:[UIColor clearColor]];
    [self.label setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    [self.label setNumberOfLines:1];
    [self.contentView addSubview:self.label];
    
    // Text field
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(self.contentView.bounds.size.width/3.0, 0, self.contentView.bounds.size.width*2.0/3.0, self.contentView.bounds.size.height)];
    self.textField.font = [JLCons TEXT_EDIT_FONT];
//    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    self.textField.clipsToBounds = NO;
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.textField];
}

- (void)updateUI
{
    if (self.labelText.length > 0) {
        self.label.hidden = FALSE;
        self.label.text = [self.labelText uppercaseString];
        [self.label sizeToFit];
    } else {
        [self.label.superview sendSubviewToBack:self.label];
        self.label.hidden = TRUE;
    }
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (void)setLabelText:(NSString*)text
{
    _labelText = text;
    [self updateUI];
}

- (NSString*)text {
    return self.textField.text;
}

- (void)setText:(NSString*)text {
    self.textField.text = text;
    [self updateUI];
}

@end