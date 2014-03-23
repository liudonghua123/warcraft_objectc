//
//  WarriorsHelper.h
//  warcraft
//
//  Created by 刘东华 on 3/22/14.
//  Copyright (c) 2014 刘东华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"

#define INT_OBJ(x) [NSNumber numberWithInt:x]

@interface WarriorsHelper : NSObject
@property (readonly) NSDictionary * warriors;

- (NSArray*) getWarriorSequence:(CommandType) type;
- (NSInteger) getMinHealthValue;

@end
