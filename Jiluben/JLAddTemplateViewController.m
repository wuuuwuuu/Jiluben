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

@interface JLAddTemplateViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, MultiColumnTableCellDelegate>
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
    TableRowTitleSection,
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

    // Template name text field.
//    self.isDefaultName = YES;
//    [self.templateName setReturnKeyType:UIReturnKeyDone];
//    [self.templateName addTarget:self action:@selector(fieldNameTextFieldActive) forControlEvents:UIControlEventEditingDidBegin];
//    self.templateName.delegate = self;

    // Field table view.
    [self loadTableView];
    //self.viewContainer.bounds
//    self.table = [[UITableView alloc] initWithFrame:CGRectMake(self.viewContainer.frame.origin.x,self.viewContainer.frame.origin.y,self.viewContainer.frame.size.width,self.viewContainer.frame.size.height) style:UITableViewStylePlain];
//    self.fieldTable.delegate = self;
//    self.fieldTable.dataSource = self;
//    [self.view addSubview:self.table];

    // Build view.
    
//    [self.templateName addTarget:delegate action:@selector(textField1Active:) forControlEvents:UIControlEventEditingDidBegin];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Init a new template.
    self.template = [[JLTemplate alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTableView
{
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
//    self.tableColumnData = [[NSMutableArray alloc] init];
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
- (void)addTemplateToServer:(UIButton *)sender
{
    NSLog(@"Add template to server");
    // new template name.
//    self.template.name = [self.templateName text];
    
    PFObject *parseTemplate = [PFObject objectWithClassName:@"JLTemplate"];
    parseTemplate[@"name"] = self.template.name;
    
    NSMutableArray *parseFields = [[NSMutableArray alloc] init];
    NSMutableArray *array = self.template.fields;
    for (JTField *field in array) {
        [parseFields addObject:[field stringifyField]];
    }
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

//- (IBAction)addTemplateToServer:(UIButton *)sender {
//    // Send to Parse.
//    
//    PFObject *parseTemplate = [PFObject objectWithClassName:@"JLTemplate"];
//    parseTemplate[@"name"] = @"test template";
//    parseTemplate[@"fields"] = @[@"f1", @"f2"];
//    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
//    
//    [parseTemplate saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if (succeeded) {
//            NSLog(@"success.");
//        } else {
//            NSLog(@"error");
//        }
//    }];
//}

#pragma mark UITableViewDataSource
//- (TableLogicalRow)indexPath2TableRow:(NSIndexPath*)indexPath
//{
//    if (indexPath.section == 0) { return TableRowTitle; }
//    if (indexPath.section == 1) { return TableRowColumns; }
//    return UNKNOWN_Table_ROW;
//}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section) {      return 20.0f; }
    if (1 == section) {      return 20.0f; }
    if (2 == section) {      return 20.0f; }
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
    return TableSectionOtherNumRows;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    TableLogicalRow logicalRow = [self indexPath2TableRow:indexPath];
    if (TableRowTitle == logicalRow) {
        return self.titleView;
    }

    if (logicalRow == TableRowColumns) {
        static NSString* CellIdentifier = @"ReusableJLTemplateColumnCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.textLabel.text = [self.tableColumnData objectAtIndex:indexPath.row];
        }
        //    cell.delegate = self;
        return cell;
    }
    
    return nil;
}

//#pragma mark MultiColumnTableCellDelegate
//- (void)cellDidTapOnAddRow:(UITableViewCell *)cell
//{
//    NSLog(@"click on cell");
//    NSString *name = [(MultiColumnTableCell *)cell getNameText];
//    NSString *type = [(MultiColumnTableCell *)cell getTypeText];
//    JTField *fieldFromColumn = [[JTField alloc] initWithName:name withType:type];
//    if([self.template addField:fieldFromColumn]) {
//        // add new empty column.
//        [self.view endEditing:YES];
//        [self.tableData addObject:fieldFromColumn];
//        [self.tableView reloadData];
//    } else {
//        NSLog(@"dup name");
//    }
//}
//
//- (void)cellDidTapOnDeleteRow:(UITableViewCell *)cell
//{
//    NSLog(@"click to delete row cell");
//    
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    
//    if([self.template removeField:[(MultiColumnTableCell *)cell getNameText]]) {
//        [self.tableView beginUpdates];
////        [self.tableData removeObjectAtIndex:row];
//        for (JTField *field in self.tableData) {
//            if ([[(MultiColumnTableCell *)cell getNameText] isEqualToString:field.name]) {
//                [self.tableData removeObject:field];
//                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//                break;
//            }
//        }
////        [self.fieldTable reloadData];
//        [self.tableView endUpdates];
//    }
//}

#pragma mark TextField on tap, allow editing and return.
//- (void)fieldNameTextFieldActive
//{
//    if (self.isDefaultName) {
//        self.templateName.text = nil;
//        self.isDefaultName = NO;
//    }
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

@end