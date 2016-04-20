//
//  JLKeyValueCell.h
//  Jiluben
//
//  Created by Yue Wu on 4/13/16.
//  Copyright © 2016 Yue. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface JLKeyValueCell : UITableViewCell

@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) NSString *keyLabelText;

@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) NSString *valueLabelText;

@end
