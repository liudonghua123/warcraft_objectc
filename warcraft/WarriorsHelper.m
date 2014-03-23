//
//  WarriorsHelper.m
//  warcraft
//
//  Created by 刘东华 on 3/22/14.
//  Copyright (c) 2014 刘东华. All rights reserved.
//

#import "WarriorsHelper.h"
#import "Warrior.h"

@implementation WarriorsHelper

-(id) init {
    self = [super init];
    if (self) {
        [self prepareWarriorData];
    }
    return self;
}

- (NSDictionary*) prepareWarriorData {
    int healthPointArray[5] = {0};
    if(scanf("%d %d %d %d %d", &healthPointArray[0], &healthPointArray[1], &healthPointArray[2], &healthPointArray[3], &healthPointArray[4]) != 5) {
        healthPointArray[0] = 3;
        healthPointArray[1] = 4;
        healthPointArray[2] = 5;
        healthPointArray[3] = 6;
        healthPointArray[4] = 7;
    }
    _warriors = @{
                  INT_OBJ(DRAGON) : [[Warrior alloc] initWithHealthPoint:healthPointArray[0] warriorProfession:DRAGON],
                  INT_OBJ(NINJA) : [[Warrior alloc] initWithHealthPoint:healthPointArray[1] warriorProfession:NINJA],
                  INT_OBJ(ICEMAN) : [[Warrior alloc] initWithHealthPoint:healthPointArray[2] warriorProfession:ICEMAN],
                  INT_OBJ(LION) : [[Warrior alloc] initWithHealthPoint:healthPointArray[3] warriorProfession:LION],
                  INT_OBJ(WOLF) : [[Warrior alloc] initWithHealthPoint:healthPointArray[4] warriorProfession:WOLF]
                  };
    return _warriors;
}

- (NSArray*) getWarriorSequence:(CommandType) type {
    NSArray * warriorSequence;
    switch (type) {
        case RED:
            warriorSequence = @[
                                INT_OBJ(ICEMAN),
                                INT_OBJ(LION),
                                INT_OBJ(WOLF),
                                INT_OBJ(NINJA),
                                INT_OBJ(DRAGON)
                                ];
            break;
        case BLUE:
            warriorSequence = @[
                                INT_OBJ(LION),
                                INT_OBJ(DRAGON),
                                INT_OBJ(NINJA),
                                INT_OBJ(ICEMAN),
                                INT_OBJ(WOLF)
                                ];
            break;
        default:
            break;
    }
    return warriorSequence;
}

- (NSInteger) getMinHealthValue {
    // minHealth should initialize max integer value
    NSInteger minHealth = 1000;
    Warrior * minHealthWarrior;
    for (id warrior in [_warriors allValues]) {
        if ([warrior healthPoint] < minHealth ) {
            minHealth = [warrior healthPoint];
            minHealthWarrior = warrior;
        }
    }
    return [minHealthWarrior healthPoint];
}

@end
