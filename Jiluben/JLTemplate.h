//
//  JLTemplate.h
//  Jiluben
//
//  Created by Yue on 12/23/15.
//  Copyright © 2015 Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JTField.h"

@interface JLTemplate : NSObject

@property(nonatomic, strong) NSString *entityId; // objective id on parse.

@property(nonatomic, strong) NSString *name; // template name.

@property(nonatomic, strong) NSMutableArray *fields; // column name and type.

@property(nonatomic, strong) NSMutableArray *records;

- (BOOL)addField:(JTField *)field;
- (BOOL)removeField:(NSString *)fieldName;
@end
