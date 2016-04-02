//
//  JTField.h
//  Jiluben
//
//  Created by Yue on 1/16/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JTField : NSObject

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *type;

- (instancetype)initWithName:(NSString *)name withType:(NSString *)type;

- (NSString *)stringifyField;

@end
