//
//  JLStyledInputViewCell.h
//  Jiluben
//
//  Created by Yue on 2/15/16.
//  Copyright © 2016 Yue. All rights reserved.
//
//  Different types of table cells.
//

#import <UIKit/UIKit.h>

@interface JLStyledTextFieldCell : UITableViewCell
@property (nonatomic, strong) UITextField* textField;
@property (nonatomic, strong) NSString* text;
+ (CGFloat)heightForCell:(CGFloat)width;
- (BOOL)becomeFirstResponder;

@property NSInteger maxLength;
@property NSInteger minLength;
- (BOOL)isValid;

@property (nonatomic, strong) NSString* errorText;

@property (nonatomic, strong) UILabel* label;
@property (nonatomic, strong) NSString* labelText;
@property (nonatomic, strong) UIView* viewHolder;
- (void)addLabelledView:(UIView*)labelledView;
- (id)initWithLabel:(NSString*)label;
//+ (CGFloat)heightForCell:(CGFloat)width;
+ (UIFont*)fontForLabel;
@end
