//
//  JLTemplate.m
//  Jiluben
//
//  Created by Yue on 12/23/15.
//  Copyright © 2015 Yue. All rights reserved.
//

#import "JLTemplate.h"
#import <Parse/Parse.h>

@interface JLTemplate()

@property(nonatomic, strong) NSMutableArray *fieldNames;

@end

@implementation JLTemplate

// Initilize.
- (instancetype)init
{
    self = [super init];
    if (self) {
        // Init with empty field names.
        self.fieldNames = [[NSMutableArray alloc]init];
        self.fields = [[NSMutableArray alloc]init];
    }
//    _name = @"test template";
//    _fields = @[@"f1", @"f2"];
    return self;
}

/**
 * Init with template name.
 */
- (instancetype)initWithName:(NSString *)name
{
    self = [self init];
    if (self) {
        self.name = name;
    }
    return self;
}

/**
 * Add a field to template.
 * return: YES, field is added.
 *         NO, duplicate field name, field is not added.
 **/
- (BOOL)addField:(JTField *)field
{
    NSString *fieldName = field.name;
    if (![self.fieldNames containsObject:fieldName]) {
        [self.fieldNames addObject:fieldName];
        [self.fields addObject:field];
        return YES;
    } else {
        // field name already exist.
        NSLog(@"Warning: field name %@ already exist.", fieldName);
        return NO;
    }
}

- (BOOL)removeField:(NSString *)fieldName
{
    for (NSString *name in self.fieldNames) {
        if (name == fieldName) {
            [self.fieldNames removeObject:name];
            break;
        }
    }
    
    for (JTField *field in self.fields) { // field is JSON string here! FIX!
        if (field.name == fieldName) {
            [self.fields removeObject:field];
            break;
        }
    }
    
    return YES;
}

- (NSMutableArray *)records
{
    if (_records) {
        return _records;
    }
    // Get records from parse, passing template id as key
    PFQuery *query = [PFQuery queryWithClassName:@"JLRecord"];
    [query whereKey:@"templateId" equalTo:self.entityId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (id object in objects) {
            [_records addObject:object];
        }
    }];
    return _records;
}

//- (NSMutableArray<NSString *> *)existingFieldNames
//{
//    NSMutableArray *fields = self.fields;
//    NSMutableArray *fieldNames = [[NSMutableArray alloc]init];
//    for (JTField *eachField in fields) {
//        [fieldNames addObject: eachField.name];
//    }
//    return fieldNames;
//}

@end
