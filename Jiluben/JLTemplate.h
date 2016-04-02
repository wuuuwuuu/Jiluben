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

@property(nonatomic, strong) NSNumber *entityId;

@property(nonatomic, strong) NSString *name;

@property(nonatomic, strong) NSMutableArray *fields;

- (BOOL)addField:(JTField *)field;
- (BOOL)removeField:(NSString *)fieldName;
@end
