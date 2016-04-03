//
//  JLColumnTypeViewController.m
//  Jiluben
//
//  Created by Yue on 4/2/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import "JLColumnTypeViewController.h"
#import "JLTableView.h"

@interface JLColumnTypeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) JLTableView *tableView;

@end

@implementation JLColumnTypeViewController

static NSArray *COLUMN_TYPES;

+ (void)initialize
{
    COLUMN_TYPES = @[@"Number", @"String", @"Date"];
}

- (void)viewDidLoad {
    NSLog(@"JLColumnTypeViewController Loaded");
    
    [super viewDidLoad];
    
    self.tableView = [[JLTableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = TRUE;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"selectTypeCellReuseIdentifier"];
}

#pragma mark UITableViewDataSource
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [COLUMN_TYPES count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectTypeCellReuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [COLUMN_TYPES objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate cellDidTapOnType:[COLUMN_TYPES objectAtIndex:indexPath.row]];
}

@end