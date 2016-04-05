//
//  JLStartingViewController.m
//  Jiluben
//
//  Created by Yue Wu on 4/5/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import "JLStartingViewController.h"
#import "JLAddTemplateViewController.h"

@interface JLStartingViewController ()

@property (nonatomic, strong) UIView *upperView;
@property (nonatomic, strong) UIView *lowerView;

@end

@implementation JLStartingViewController

- (void)viewDidLoad {
    NSLog(@"JLStartingViewController Loaded");
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Upper view with a "add template button".
    self.upperView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 100.0)];
    self.upperView.backgroundColor = [UIColor redColor];
    UIButton *addTemplate = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-22, 50-22, 44, 44.0)];
    addTemplate.backgroundColor = [UIColor blueColor];
    [addTemplate setTitle:@"Add New Template" forState:UIControlStateNormal];
    [addTemplate addTarget:self action:@selector(handleAddTemplateButtonTap) forControlEvents:UIControlEventTouchUpInside];
    [self.upperView addSubview:addTemplate];
    
    // Lower view with existing templates.
//    self.lowerView
    
    
    [self.view addSubview:self.upperView];
//    [self.view addSubview:self.lowerView];
}

- (void)handleAddTemplateButtonTap
{
    JLAddTemplateViewController *vc = [[JLAddTemplateViewController alloc] init];
    // Add nav controller and present it.
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: vc];
    [self presentViewController:navController animated:YES completion:nil];
}

@end