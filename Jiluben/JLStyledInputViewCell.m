//
//  JLStyledInputViewCell.m
//  Jiluben
//
//  Created by Yue on 2/15/16.
//  Copyright © 2016 Yue. All rights reserved.
//
#import "JLStyledInputViewCell.h"
#import "JLCons.h"

@interface JLStyledTextFieldCell ()
@property (nonatomic, strong) UILabel* errorLabel;
@end

#pragma mark -
@implementation JLStyledTextFieldCell

- (id)initWithLabel:(NSString*)label
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 100)];
    if (self) {
        [self initUI];
        [self setLabelText:[label uppercaseString]];
    }
    return self;
}

- (void)initUI
{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,
                                                           self.contentView.bounds.size.width,
                                                           ceilf(JLStyledTextFieldCell.fontForLabel.lineHeight))]; //ceilf(JLStyledTextFieldCell.fontForLabel.lineHeight)
    [self.label setFont:JLStyledTextFieldCell.fontForLabel];
    [self.label setTextColor:[JLCons META_COLOR]];
    [self.label setBackgroundColor:[UIColor clearColor]]; //[UIColor redColor]];//
    [self.label setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
    [self.label setNumberOfLines:1];
    [self.contentView addSubview:self.label];
    
    self.viewHolder = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                               self.label.bounds.size.height,
                                                               self.contentView.bounds.size.width,
                                                               self.contentView.bounds.size.height - self.label.bounds.size.height)];
    [self.viewHolder setBackgroundColor:[UIColor clearColor]];
    [self.viewHolder setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.contentView addSubview:self.viewHolder];
    
    
//    self.errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, [PVCons HEADER2_FONT].integralLineHeight)];
//    self.errorLabel.textColor = [PVCons ERROR_TEXT_COLOR];
//    self.errorLabel.font = [PVCons HEADER2_FONT];
//    self.errorLabel.minimumScaleFactor = 0.5f;
//    self.errorLabel.adjustsFontSizeToFitWidth = YES;
//    self.errorLabel.backgroundColor = [UIColor clearColor];
//    // self.errorLabel.backgroundColor = [UIColor greenColor];
//    [self.contentView addSubview:self.errorLabel];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToEdit:)];
    [self addGestureRecognizer:tap];
    tap.delegate = self;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    self.textField = [[UITextField alloc] initWithFrame:self.viewHolder.bounds];
    self.textField.font = [JLCons TEXT_EDIT_FONT];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.clipsToBounds = NO;
    self.textField.borderStyle = UITextBorderStyleNone;
     self.textField.backgroundColor = [UIColor clearColor];
    [self.viewHolder addSubview:self.textField];
    [self addLabelledView:self.textField];
}

- (NSString*)text {
    return self.textField.text;
}

- (void)setText:(NSString*)text {
    self.textField.text = text;
    [self updateUI];
}

- (void)addLabelledView:(UIView*)view
{
    [self.viewHolder addSubview:view];
    [self setNeedsDisplay];
    [self setNeedsLayout];
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = self.contentView.bounds.size;
    
    CGFloat bottomOfLabel = 0.0f;
    if (!self.label.hidden) {
        bottomOfLabel = CGRectGetMaxY(self.label.frame) + 0.0f;
    }
    
    self.viewHolder.frame = CGRectMake(0,bottomOfLabel,size.width,size.height - bottomOfLabel);
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    ((UIView*)[self.viewHolder.subviews lastObject]).frame = UIEdgeInsetsInsetRect(self.viewHolder.bounds, UIEdgeInsetsMake(-8, -8, 0, 0));
//}

+ (CGFloat)heightForCell:(CGFloat)width
{
    return 200;//ceilf(4*[JLCons TEXT_EDIT_FONT].lineHeight);//+[PVStyledLabelledEditableViewCell heightForCell:width];
}

- (BOOL)isValid
{
    if (self.minLength && self.text.length < self.minLength) {
        self.errorText = @"Too short";
        return FALSE;
    }
    if (self.maxLength && self.text.length > self.maxLength) {
        self.errorText = @"Too long";
        return FALSE;
    }
    return TRUE;
}

- (BOOL)becomeFirstResponder
{
    return [self.textField becomeFirstResponder];
}

- (void)tapToEdit:(id)view
{
    UIView* v = ((UIView*)[self.viewHolder.subviews lastObject]);
    if ([v canBecomeFirstResponder]) {
        [v becomeFirstResponder];
    }
}

+ (UIFont*)fontForLabel
{
    return [JLCons HEADER2_FONT];
}

- (void)setLabelText:(NSString*)text
{
    _labelText = text;
    [self updateUI];
}

@end
