//
//  Warrior.m
//  warcraft
//
//  Created by 刘东华 on 3/22/14.
//  Copyright (c) 2014 刘东华. All rights reserved.
//

#import "Warrior.h"

@implementation Warrior

- (id)init {
    return [self initWithHealthPoint:0 warriorProfession:0 number:0 attackPoint:LION];
}

- (id)initWithHealthPoint: (NSInteger)healthPoint warriorProfession:(WarriorProfession)warriorProfession {
    return [self initWithHealthPoint:healthPoint warriorProfession:warriorProfession number:0 attackPoint:LION];
}

- (id)initWithHealthPoint: (NSInteger)healthPoint warriorProfession:(WarriorProfession)warriorProfession number: (NSInteger) number attackPoint:(NSInteger) attackPoint {
    self = [super init];
    if (self) {
        _number = number;
        _healthPoint = healthPoint;
        _attackPoint = attackPoint;
        _warriorProfession = warriorProfession;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    // http://stackoverflow.com/questions/1459598/how-to-copy-an-object-in-objective-c
    Warrior *warrior = [[Warrior alloc] initWithHealthPoint:[self healthPoint] warriorProfession:[self warriorProfession]];
    return warrior;
}

@end
