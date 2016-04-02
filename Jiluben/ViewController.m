//
//  ViewController.m
//  Jiluben
//
//  Created by Yue on 12/22/15.
//  Copyright © 2015 Yue. All rights reserved.
//

#import "ViewController.h"
#import "JLTemplate.h"
#import <Parse/Parse.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *templateButtons;
@property (strong, nonatomic) NSMutableArray *templates;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Loaded");
    
    [self getTemplatesFromServer];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getTemplatesFromServer
{
    self.templates = [[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"JLTemplate"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        // posts are posts where post.user.userType == X
        for (id object in objects) {
            [self.templates addObject:object];
        }
        
        if ([self.templates count]) {
            for (int i = 0; i < [self.templateButtons count]; i++) {
                UIButton *button = [self.templateButtons objectAtIndex:i];
                PFObject *template = [self.templates objectAtIndex:i];
                if (template) {
                    [button setTitle:template[@"name"] forState:UIControlStateNormal];
                }
            }
        }
    }];
}

@end
