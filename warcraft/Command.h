//
//  Command.h
//  warcraft
//
//  Created by 刘东华 on 3/22/14.
//  Copyright (c) 2014 刘东华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"
#import "WarriorsHelper.h"
#import "Warrior.h"

@interface Command : NSObject

@property (readonly) NSInteger totalHealthPoint;
@property (readonly) CommandType commandType;
@property (readonly) WarriorsHelper * warriorsHelper;
@property (readonly) NSMutableArray * createdWarrior;

-(id) initWithTotalHealthPoint: (NSInteger) totalHealthPoint commandType:(CommandType) commandType warriorsHelper:(WarriorsHelper *) warriorsHelper;

-(BOOL) canCreateWarrior;
-(void) createWarrior;
-(NSInteger) getWarriorIndex:(Warrior *) warrior;

@end
