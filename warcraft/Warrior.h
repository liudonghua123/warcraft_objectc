//
//  Warrior.h
//  warcraft
//
//  Created by 刘东华 on 3/22/14.
//  Copyright (c) 2014 刘东华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"

@interface Warrior : NSObject <NSCopying> 

@property (readonly) NSInteger number;
@property (readonly) NSInteger healthPoint;
@property (readonly) NSInteger attackPoint;
@property (readonly) WarriorProfession warriorProfession;

- (id)init;
- (id)initWithHealthPoint: (NSInteger)healthPoint warriorProfession:(WarriorProfession)warriorProfession;
- (id)initWithHealthPoint: (NSInteger)healthPoint warriorProfession:(WarriorProfession)warriorProfession number: (NSInteger) number attackPoint:(NSInteger) attackPoint;

@end
