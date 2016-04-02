//
//  MultiColumnTableCell.h
//  Jiluben
//
//  Created by Yue on 1/18/16.
//  Copyright © 2016 Yue. All rights reserved.
//
// TO DISCARD
#import <UIKit/UIKit.h>

@protocol MultiColumnTableCellDelegate <NSObject>

- (void)cellDidTapOnAddRow:(UITableViewCell *)cell;
- (void)cellDidTapOnDeleteRow:(UITableViewCell *)cell;

@end

@interface MultiColumnTableCell : UITableViewCell

@property (nonatomic, weak) id <MultiColumnTableCellDelegate> delegate;

- (NSString *)getNameText;
- (NSString *)getTypeText;

@end
