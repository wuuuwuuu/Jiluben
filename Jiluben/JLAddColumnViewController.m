//
//  JLAddColumnViewController.m
//  Jiluben
//
//  Created by Yue on 4/2/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import "JLAddColumnViewController.h"
#import "JLTableView.h"
#import "JLStyledInputViewCell.h"
#import "JLColumnTypeViewController.h"

@interface JLAddColumnViewController ()<UITableViewDelegate, UITableViewDataSource, JLColumnTypeViewControllerDelegate>

@property (nonatomic, strong) JLTableView *tableView;
@property (nonatomic, strong) JLStyledTextFieldCell *titleView;
@property (nonatomic, strong) UITableViewCell *typeView;

@property (nonatomic, strong) NSString *columnTitle;
@property (nonatomic, strong) NSString *columnType;

@end

@implementation JLAddColumnViewController

- (void)viewDidLoad {
    NSLog(@"JLAddColumnViewController Loaded");
    
    [super viewDidLoad];
    
    // navigation button.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addColumnToTemplate)];
    // Add table view.
    self.tableView = [[JLTableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = TRUE;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
    // Column Title view.
    self.titleView = [[JLStyledTextFieldCell alloc] initWithLabel:@"Title"];
    self.titleView.textField.placeholder = @"Column Name";
//    [self.titleView.textField addTarget:self action:@selector() forControlEvents:UIControlEventEditingChanged];
    
    // Add Column type view.
    self.typeView = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    self.typeView.textLabel.text = @"Add Type";
}

- (void)addColumnToTemplate
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate didAddColumnTitle:self.titleView.textField.text withType:self.columnType];
}

#pragma mark UITableViewDataSource
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section) {      return 20.0f; }
    if (1 == section) {      return 20.0f; }
    return 0.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) { return 1; }
    if (1 == section) { return 1; }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSInteger logicalRow = indexPath.section;
    // Show of title.
    if (0 == logicalRow) {
        return self.titleView;
    }

    // View of add column.
    if (1 == logicalRow) {
        return self.typeView;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger logicalRow = indexPath.section;
    
    if (1 == logicalRow) {
        NSLog(@"Add column type");
        JLColumnTypeViewController *vc = [[JLColumnTypeViewController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark JLColumnTypeViewControllerDelegate
- (void)cellDidTapOnType:(NSString *)type
{
    NSLog(@"Selected: %@", type);
    self.columnType = type;
}

@end