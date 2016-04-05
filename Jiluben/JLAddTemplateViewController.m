//
//  JLAddTemplateViewController.m
//  Jiluben
//
//  Created by Yue on 12/23/15.
//  Copyright © 2015 Yue. All rights reserved.
//

#import "JLAddTemplateViewController.h"
#import "JLTemplate.h"
#import "JTField.h"
#import "MultiColumnTableCell.h"
#import <Parse/Parse.h>
#import "JLStyledInputViewCell.h"
#import "JLTableView.h"
#import "JLAddColumnViewController.h"

@interface JLAddTemplateViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, JLAddColumnViewControllerDelegate>
//@property (weak, nonatomic) IBOutlet UITextField *templateName;
//- (IBAction)addTemplateToServer:(UIButton *)sender;
//@property (weak, nonatomic) IBOutlet UITableView *fieldTable;
//@property (weak, nonatomic) IBOutlet UIView *viewContainer;
//@property (weak, nonatomic) IBOutlet UITableView *fieldTable;
@property (strong, nonatomic) UITableView *table;

@property (strong, nonatomic) JLTemplate *template;
//@property BOOL isDefaultName;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) NSMutableArray *tableColumnData;
@property (nonatomic, strong) JLStyledTextFieldCell *titleView;
@property (nonatomic, strong) UITableViewCell *addColumnView;
@property (nonatomic, strong) JLTableView *tableView;
@end

@implementation JLAddTemplateViewController

typedef enum {
    TableRowTitleSection = 0,
    TableRowColumnsSection,
    TableRowAddColumnSection,
    UNKNOWN_Table_ROWSection
} TableLogicalRow;

typedef enum {
    TableRowTitleSectionNumRows = 1,
    TableRowAddColumnSectionNumRows = 1
} TableSectionNumRows;

- (void)viewDidLoad {
     NSLog(@"JLAddTemplateViewController Loaded");

    [super viewDidLoad];

    // Navigation button.
    self.navigationItem.title = @"New Template";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addNewTemplateToServer)];
    
    // Field table view.
    [self loadTableView];
    
    // Init a new template.
    self.template = [[JLTemplate alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTableView
{
    // Add table to view.
    self.tableView = [[JLTableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = TRUE;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];

    // Title view.
    self.titleView = [[JLStyledTextFieldCell alloc] initWithLabel:@"Title"];
    self.titleView.textField.placeholder = @"Template Name";
    [self.titleView.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Column view.
    self.tableColumnData = [[NSMutableArray alloc] init];
    //JTField *field = [[JTField alloc] init];
//    [self.tableColumnData addObject:@"Add Column"];

    // Add Column view.
    self.addColumnView = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    self.addColumnView.textLabel.text = @"Add Column";

    [self.tableView reloadData];
}

- (void)textFieldDidChange :(UITextField *)theTextField{
}

/**
 * Add a view field to template.
 */
//- (void)addNewColumn:(NSString *)name ofType:(NSString *)type
//{
//    JTField *fieldFromColumn = [[JTField alloc] initWithName:name withType:type];
//    [self.template addField:fieldFromColumn];
//}


/**
 * Post template to parse.
 */
- (void)addNewTemplateToServer
{
    NSLog(@"Add template to server");
    // new template name.
//    self.template.name = [self.templateName text];
    
    PFObject *parseTemplate = [PFObject objectWithClassName:@"JLTemplate"];
    parseTemplate[@"name"] = self.titleView.textField.text;// self.template.name;
    
    NSMutableArray *parseFields = self.tableColumnData;//[[NSMutableArray alloc] init];
//    NSMutableArray *array = self.template.fields;
//    for (JTField *field in array) {
//        [parseFields addObject:[field stringifyField]];
//    }
    parseTemplate[@"fields"] = parseFields;
    
    [parseTemplate saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"success.");
        } else {
            NSLog(@"error");
        }
    }];
}

#pragma mark UITableViewDataSource
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section) {      return 20.0f; }
    if (1 == section) {      return 20.0f; }
    if (2 == section) {      return 20.0f; }
    return 0.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) { return 1; }
    if (1 == section) { return [self.tableColumnData count]; }
    if (2 == section) { return 1; }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSInteger logicalRow = indexPath.section;
    // Show of title.
    if (0 == logicalRow) {
        return self.titleView;
    }

    if (logicalRow == 1) {
        static NSString* CellIdentifier = @"ReusableJLTemplateColumnCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            NSDictionary *cellData = [self.tableColumnData objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"Name: %@   Type:%@", [cellData objectForKey:@"title"], [cellData objectForKey:@"type"]];
        }
        //    cell.delegate = self;
        return cell;
    }
    
    // View of add column.
    if (2 == logicalRow) {
        return self.addColumnView;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger logicalRow = indexPath.section;
    
    if (2 == logicalRow) {
        NSLog(@"Add column ba");
        JLAddColumnViewController *vc = [[JLAddColumnViewController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
//        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }
}

#pragma mark TextField on tap, allow editing and return.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark JLAddColumnViewControllerDelegate
- (void)didAddColumnTitle:(NSString *)title withType:(NSString *)type
{
    NSLog(@"set title: %@ and type: %@", title, type);
    // Update TableRowColumnsSection.
    [self.tableColumnData addObject:@{@"title":title, @"type":type}];
    [self.tableView reloadData];
}

@end