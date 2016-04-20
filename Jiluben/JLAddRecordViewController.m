//
//  JLAddRecordViewController.m
//  Jiluben
//
//  Created by Yue Wu on 4/9/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import "JLAddRecordViewController.h"
#import "JLTableView.h"
#import "JLHorizontalTitleTextCell.h"
#import "JLAddDetailDataViewController.h"
#import "JLKeyValueCell.h"
#import <Parse/Parse.h>

@interface JLAddRecordViewController ()<UITableViewDelegate, UITableViewDataSource, JLAddDetailDataViewControllerDelegate>

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
    
    [self.tableView registerClass:[JLKeyValueCell class] forCellReuseIdentifier:@"selectTypeCellReuseIdentifier"];
}

- (void)addNewRecordToServer
{
    NSLog(@"Add record to server");
    
    PFObject *parseTemplate = [PFObject objectWithClassName:@"JLRecord"];
    parseTemplate[@"templateId"] = self.jlTemplate.entityId;
    
    NSMutableArray *parseFields = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in self.jlTemplate.fields) {
        [parseFields addObject:@{[dic valueForKey:@"title"] : [dic valueForKey:@"value"]}];
    }
    parseTemplate[@"data"] = parseFields;
    
    [parseTemplate saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"success.");
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"error");
        }
    }];
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
//    JLHorizontalTitleTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectTypeCellReuseIdentifier" forIndexPath:indexPath];
//    NSDictionary *field = [self.jlTemplate.fields objectAtIndex:indexPath.row];
//    cell.labelText = [field valueForKey:@"title"];
////    cell.textLabel = [field valueForKey:@"title"];
////    cell = [[JLHorizontalTitleTextCell alloc] initWithLabel:[field valueForKey:@"title"]];
//    return cell;
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectTypeCellReuseIdentifier" forIndexPath:indexPath];
//    NSDictionary *field = [self.jlTemplate.fields objectAtIndex:indexPath.row];
//    cell.textLabel.text = [field valueForKey:@"title"];
//    return cell;
    
    JLKeyValueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectTypeCellReuseIdentifier" forIndexPath:indexPath];
    NSDictionary *field = [self.jlTemplate.fields objectAtIndex:indexPath.row];
    cell.keyLabelText = [field valueForKey:@"title"];
    cell.valueLabelText = [field valueForKey:@"value"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Check cell type:
    // String -> see workout notes
    // Date -> see
    // Int -> see my bodyweight
    JLAddDetailDataViewController *vc = [[JLAddDetailDataViewController alloc] init];
    NSDictionary *field = [self.jlTemplate.fields objectAtIndex:indexPath.row];
    vc.dataTitle = [field valueForKey:@"title"];
    vc.indexPathRow = indexPath.row;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.delegate cellDidTapOnType:[COLUMN_TYPES objectAtIndex:indexPath.row]];
}

- (void)cellDidaddData:(NSString *)data toRow:(NSInteger)row
{
    NSDictionary *field = [self.jlTemplate.fields objectAtIndex:row];
    [field setValue:data forKey:@"value"];
    NSLog(@"data is: %@", data);
    [self.tableView reloadData];
    
}

@end
