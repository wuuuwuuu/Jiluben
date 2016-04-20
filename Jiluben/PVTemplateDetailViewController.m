//
//  PVTemplateDetailViewController.m
//  Jiluben
//
//  Created by Yue Wu on 4/6/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import "PVTemplateDetailViewController.h"
#import "JLAddRecordViewController.h"
#import <Parse/Parse.h>

@interface PVTemplateDetailViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UIView *upperView;
@property (nonatomic, strong) UIView *lowerView;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;

@end

@implementation PVTemplateDetailViewController

static NSString *cellIdentifier = @"ReusableJLRecordCell";

- (void)viewDidLoad {
    NSLog(@"PVTemplateDetailViewController Loaded");
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Upper view with a "add template button".
    self.upperView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, 100.0)];
    self.upperView.backgroundColor = [UIColor redColor];
    UIButton *addRecord = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 50-22, 100, 44.0)];
    addRecord.backgroundColor = [UIColor blueColor];
    [addRecord setTitle:@"Add New Record" forState:UIControlStateNormal];
    [addRecord addTarget:self action:@selector(handleAddRecordButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.upperView addSubview:addRecord];
    
    // Lower view with existing records.
    self.lowerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.upperView.frame.origin.y + self.upperView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.upperView.frame.size.height)];
    self.lowerView.backgroundColor = [UIColor clearColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.lowerView.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = TRUE;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.lowerView addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    // Load table data.
    self.tableData = [[NSMutableArray alloc] init];
//    [self loadRecordFromServerForTemplateId:self.jlTemplate.entityId];
    //
//    self.tableData = self.jlTemplate.records;
//    [self.tableView reloadData];
    
    // Add to view.
    [self.view addSubview:self.upperView];
    [self.view addSubview:self.lowerView];
}

- (void)setJlTemplate:(JLTemplate *)jlTemplate
{
    if ([_jlTemplate isEqual:jlTemplate]) {
        return;
    }
    _jlTemplate = jlTemplate;
    
    [self updateDataSource];
}

- (void)updateDataSource
{
    if (!self.jlTemplate) {
        return;
    }
    self.tableData = self.jlTemplate.records;
}

#pragma mark Add New Record
- (void)handleAddRecordButtonTap
{
    JLAddRecordViewController *vc = [[JLAddRecordViewController alloc] init];
    vc.jlTemplate = self.jlTemplate;
    // Add nav controller and present it.
    [self.navigationController pushViewController:vc animated:YES];
}
    
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"ReusableJLTemplateCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSLog(@"hehe %@",[self.tableData objectAtIndex:indexPath.row]);
    cell.textLabel.text =@"123";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"clicked");
}

@end