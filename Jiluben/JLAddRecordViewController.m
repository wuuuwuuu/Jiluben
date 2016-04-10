//
//  JLAddRecordViewController.m
//  Jiluben
//
//  Created by Yue Wu on 4/9/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import "JLAddRecordViewController.h"
#import "JLTableView.h"

@interface JLAddRecordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) JLTableView *tableView;

@end

@implementation JLAddRecordViewController

- (void)viewDidLoad {
    NSLog(@"JLAddRecordViewController Loaded");
    
    [super viewDidLoad];
    
    // Navigation button.
    self.navigationItem.title = @"New Record";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addNewRecordToServer)];
    
    // columns.
    self.tableView = [[JLTableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = TRUE;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"selectTypeCellReuseIdentifier"];
}

- (void)addNewRecordToServer
{
    // TODO.
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
    return [self.jlTemplate.fields count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectTypeCellReuseIdentifier" forIndexPath:indexPath];
    NSDictionary *field = [self.jlTemplate.fields objectAtIndex:indexPath.row];
    cell.textLabel.text = [field valueForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.delegate cellDidTapOnType:[COLUMN_TYPES objectAtIndex:indexPath.row]];
}

@end
