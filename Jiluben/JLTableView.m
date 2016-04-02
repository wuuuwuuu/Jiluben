//
//  JLTableView.m
//  Jiluben
//
//  Created by Yue on 2/15/16.
//  Copyright © 2016 Yue. All rights reserved.
//
//  Extends from UITableView. Custom
//  Now only hide the separators between cells when we have no content

#import <Foundation/Foundation.h>
#import "JLTableView.h"

@implementation JLTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initTableView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initTableView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initTableView];
    }
    return self;
}

- (void)initTableView
{
//    self.cellCreationCount = 0;
//    self.cellCreationLimit = 40;
//    self.cellsHaveBeenReused = FALSE;
    
    // We want to hide the separators between cells when we have no content
    // http://stackoverflow.com/questions/1633966/can-i-force-a-uitableview-to-hide-the-separator-between-empty-cells
    UIView* v = [[UIView alloc] initWithFrame:CGRectZero];
    v.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:v];
}

-(void)dealloc
{
    self.dataSource = nil;
    self.delegate = nil;
}

@end