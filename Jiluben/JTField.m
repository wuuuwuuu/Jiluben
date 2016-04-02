//
//  JTField.m
//  Jiluben
//
//  Created by Yue on 1/16/16.
//  Copyright © 2016 Yue. All rights reserved.
//

#import "JTField.h"


@implementation JTField

- (instancetype)initWithName:(NSString *)name withType:(NSString *)type
{
    self = [super init];
    
    if (self) {
        self.name = name;
        self.type = type;
    }
    
    return self;
}

- (NSString *)stringifyField
{
    NSDictionary *dicField = @{@"name":self.name, @"type":self.type};
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicField
                                                           options:0
                                                             error:&error];
    NSString *resStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return resStr;
}

@end