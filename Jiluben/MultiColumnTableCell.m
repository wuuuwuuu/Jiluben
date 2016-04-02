//
//  MultiColumnTableCell.m
//  Jiluben
//
//  Created by Yue on 1/18/16.
//  Copyright © 2016 Yue. All rights reserved.
//
// TO DISCARD
#import "MultiColumnTableCell.h"
#import "UIImage+JLUtil.h"

@interface MultiColumnTableCell() <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *nameText;
@property (strong, nonatomic) UITextField *typeText;

@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UIButton *deleteButton;

@end

@implementation MultiColumnTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCellView];
    }
    return self;
}

/**
 * View look:
 * | Name: ___ | Type: ___ | Add / Delete |
 * | Name: ___ | Type: ___ | Add / Delete |
 */
- (void)createCellView
{
    CGRect frame = self.contentView.frame;

    // Name column
    UIView *nameColumn = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x,frame.origin.y,frame.size.width*2/5,self.contentView.frame.size.height)];
    nameColumn.layer.borderColor = [UIColor redColor].CGColor;
    nameColumn.layer.borderWidth = 1.0f;
//    UILabel *nameLabel = [[UILabel alloc] init];
//    nameLabel.text = @"Name: ";
    self.nameText = [[UITextField alloc] initWithFrame:nameColumn.bounds];
    self.nameText.delegate = self;
//    [nameColumn addSubview:nameColumn];
    [nameColumn addSubview:self.nameText];
    [self.contentView addSubview:nameColumn];
    
    // Type column
    UIView *typeColumn = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x+frame.size.width*2/5,frame.origin.y,frame.size.width*2/5,self.contentView.frame.size.height)];
    typeColumn.layer.borderColor = [UIColor redColor].CGColor;
    typeColumn.layer.borderWidth = 1.0f;
//    UILabel *typeLabel = [[UILabel alloc] init];
//    typeLabel.text = @"Type: ";
    self.typeText = [[UITextField alloc] initWithFrame:typeColumn.bounds];
    self.typeText.delegate = self;
//    [typeColumn addSubview:typeColumn];
    [typeColumn addSubview:self.typeText];
    [self.contentView addSubview:typeColumn];

    // Add Button View
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton addTarget:self
                  action:@selector(addButtonClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    addButton.frame = CGRectMake(frame.origin.x+frame.size.width*4/5,frame.origin.y,frame.size.width/5,self.contentView.frame.size.height);
    [addButton setBackgroundImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [addButton setBackgroundImage:[UIImage imageWithColor:[UIColor blueColor] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    addButton.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin);
    [self.contentView addSubview:addButton];
    self.addButton = addButton;
    // Delete Button View.
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton addTarget:self
                  action:@selector(deleteButtonClicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    deleteButton.frame = CGRectMake(frame.origin.x+frame.size.width*4/5,frame.origin.y,frame.size.width/5,self.contentView.frame.size.height);
    [deleteButton setBackgroundImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [deleteButton setBackgroundImage:[UIImage imageWithColor:[UIColor blueColor] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    deleteButton.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin);
    deleteButton.hidden = YES;
    [self.contentView addSubview:deleteButton];
    self.deleteButton = deleteButton;
}

- (IBAction)addButtonClicked:(id)sender
{
    NSLog(@"Clicked Add button!");
    
    self.deleteButton.hidden = FALSE;
    self.addButton.hidden = TRUE;

    [self.delegate cellDidTapOnAddRow:self];
}

- (IBAction)deleteButtonClicked:(id)sender
{
    NSLog(@"Clicked Delete button!");
    
    self.deleteButton.hidden = TRUE;
    self.addButton.hidden = TRUE;
    
    [self.delegate cellDidTapOnDeleteRow:self];
}

- (NSString *)getNameText
{
    return self.nameText.text;
}

- (NSString *)getTypeText
{
    return self.typeText.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
