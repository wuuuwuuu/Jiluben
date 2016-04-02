//
//  ParseObject.h
//  Jiluben
//
//  Created by Yue on 12/23/15.
//  Copyright © 2015 Yue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseObject : NSObject

// Equivalent component of objectId property of a PFObject object. Nil if it hasn't
// been saved to the Cloud yet or an equivalent component can't be found.
@property (nonatomic, readonly) NSString *parseObjectID;

// Equivalent component of createdAt property of a PFObject object.
@property (nonatomic, strong, readonly) NSDate *parseCreatedAt;

@end
