//
//  JLKeyValueCell.m
//  Jiluben
//
//  Created by Yue Wu on 4/13/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import "JLKeyValueCell.h"

@interface JLKeyValueCell ()

@end

@implementation JLKeyValueCell

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
    self.keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.contentView.bounds.size.width/3.0, self.contentView.bounds.size.height)];
//    [self.label setFont:JLStyledTextFieldCell.fontForLabel];
//    [self.label setTextColor:[JLCons META_COLOR]];
//    [self.label setBackgroundColor:[UIColor clearColor]]; //[UIColor redColor]];//
//    [self.label setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    [self.keyLabel setNumberOfLines:1];
    [self.contentView addSubview:self.keyLabel];
    
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.bounds.size.width/3.0, 0.0, self.contentView.bounds.size.width*2.0/3.0, self.contentView.bounds.size.height)];
    [self.valueLabel setNumberOfLines:1];
    [self.contentView addSubview:self.valueLabel];
}

- (void)updateUI
{
    self.keyLabel.text = self.keyLabelText;
    self.valueLabel.text = self.valueLabelText;

    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (void)setKeyLabelText:(NSString*)text
{
    _keyLabelText = text;
    [self updateUI];
}

- (void)setValueLabelText:(NSString*)text
{
    _valueLabelText = text;
    [self updateUI];
}

@end
