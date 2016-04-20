//
//  JLAddDetailDataViewController.m
//  Jiluben
//
//  Created by Yue Wu on 4/12/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import "JLAddDetailDataViewController.h"
#import "JLTableView.h"
#import "JLTextFieldCell.h"

@interface JLAddDetailDataViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) JLTableView *tableView;
@property (nonatomic, strong) JLTextFieldCell *textDataCell;

@end

@implementation JLAddDetailDataViewController


- (void)viewDidLoad {
    NSLog(@"JLAddDetailDataViewController Loaded");
    
    [super viewDidLoad];
    
    // Navigation button.
    self.navigationItem.title = @"Data";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addData)];
    
    // Table view.
    self.tableView = [[JLTableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = TRUE;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
    self.textDataCell = [[JLTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    [self.tableView registerClass:[JLTextFieldCell class] forCellReuseIdentifier:@"selectTypeCellReuseIdentifier"];
}

#pragma mark UITableViewDataSource
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return self.textDataCell;
//    UILabelTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectTypeCellReuseIdentifier" forIndexPath:indexPath];
//    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.delegate cellDidaddData:self.textDataCell.text];
}

- (void)addData
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate cellDidaddData:self.textDataCell.text toRow:self.indexPathRow];
}

@end
