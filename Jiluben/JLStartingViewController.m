//
//  JLStartingViewController.m
//  Jiluben
//
//  Created by Yue Wu on 4/5/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import "JLStartingViewController.h"
#import "JLAddTemplateViewController.h"
#import <Parse/Parse.h>
#import "PVTemplateDetailViewController.h"

@interface JLStartingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *upperView;
@property (nonatomic, strong) UIView *lowerView;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;

@end

@implementation JLStartingViewController

- (void)viewDidLoad {
    NSLog(@"JLStartingViewController Loaded");
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Upper view with a "add template button".
    self.upperView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 100.0)];
    self.upperView.backgroundColor = [UIColor redColor];
    UIButton *addTemplate = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 50-22, 100, 44.0)];
    addTemplate.backgroundColor = [UIColor blueColor];
    [addTemplate setTitle:@"Add New Template" forState:UIControlStateNormal];
    [addTemplate addTarget:self action:@selector(handleAddTemplateButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.upperView addSubview:addTemplate];
    
    // Lower view with existing templates.
    self.lowerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.upperView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.upperView.frame.size.height)];
    self.lowerView.backgroundColor = [UIColor clearColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.lowerView.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = TRUE;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.lowerView addSubview:self.tableView];
    
    // Load table data.
    self.tableData = [[NSMutableArray alloc] init];
    [self loadTemplatesFromServer];
    
    // Add to view.
    [self.view addSubview:self.upperView];
    [self.view addSubview:self.lowerView];
}

#pragma mark Add New Template
- (void)handleAddTemplateButtonTap
{
    JLAddTemplateViewController *vc = [[JLAddTemplateViewController alloc] init];
    // Add nav controller and present it.
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: vc];
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark Load existing Template
- (void)loadTemplatesFromServer
{
    PFQuery *query = [PFQuery queryWithClassName:@"JLTemplate"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        // posts are posts where post.user.userType == X
        for (id object in objects) {
            [self.tableData addObject:object];
        }
        [self.tableView reloadData];
    }];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        PFObject *template = [self.tableData objectAtIndex:indexPath.row];
        cell.textLabel.text = template[@"name"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PVTemplateDetailViewController *vc = [[PVTemplateDetailViewController alloc] init];
    PFObject *pfTemplate = [self.tableData objectAtIndex:indexPath.row];
    // create template object.
    
    JLTemplate *template = [[JLTemplate alloc] init];
    template.name = [pfTemplate valueForKey:@"name"];//pfTemplate[@"name"];
    template.entityId = [pfTemplate valueForKey:@"objectId"];
    template.fields = [pfTemplate valueForKey:@"fields"];//pfTemplate[@"fields"];
    vc.jlTemplate = template;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: vc];
    [self presentViewController:navController animated:YES completion:nil];
}

@end