//
//  Command.m
//  warcraft
//
//  Created by 刘东华 on 3/22/14.
//  Copyright (c) 2014 刘东华. All rights reserved.
//

#import "Command.h"

@implementation Command {
    NSInteger _currentRemainingHealthPoint;
    NSArray * _createWarriorSequence;
    NSDictionary * _warriorData;
    WarriorProfession _currentWarriorProfession;
    
}

-(id) initWithTotalHealthPoint: (NSInteger) totalHealthPoint commandType:(CommandType) commandType warriorsHelper:(WarriorsHelper *) warriorsHelper {
    self = [super init];
    if (self) {
        _totalHealthPoint = totalHealthPoint;
        _commandType = commandType;
        _warriorsHelper = warriorsHelper;
        
        _currentRemainingHealthPoint = _totalHealthPoint;
        _createWarriorSequence = [warriorsHelper getWarriorSequence:commandType];
        _warriorData = [warriorsHelper warriors];
        _createdWarrior = [[NSMutableArray alloc] init];
        _currentWarriorProfession = [[_createWarriorSequence objectAtIndex:0] intValue];
    }
    return self;
}


-(BOOL) canCreateWarrior {
    return _currentRemainingHealthPoint >= [_warriorsHelper getMinHealthValue];
}

-(void) createWarrior {
    NSInteger currentWarriorProfessionIndex = [_createWarriorSequence indexOfObject:[NSNumber numberWithInt:_currentWarriorProfession]];
    NSMutableArray *iteratorWarriorSequence = [[NSMutableArray alloc] init];
    [iteratorWarriorSequence insertObjects:_createWarriorSequence atIndexes:[NSIndexSet indexSetWithIndexesInRange: NSMakeRange(currentWarriorProfessionIndex, [_createWarriorSequence count] - currentWarriorProfessionIndex)]];
    if (currentWarriorProfessionIndex > 0) {
        [iteratorWarriorSequence insertObjects:_createWarriorSequence atIndexes:[NSIndexSet indexSetWithIndexesInRange: NSMakeRange(0, currentWarriorProfessionIndex)]];
    }
    for (id professionObject in iteratorWarriorSequence) {
        WarriorProfession profession = [professionObject intValue];
        for (id key in [_warriorData allKeys]) {
            if (([key intValue] == profession) && ([[_warriorData objectForKey:key] healthPoint] <= _currentRemainingHealthPoint)) {
                [self createWarriorInternal: [_warriorData objectForKey:key]];
                break;
            }
        }
    }
    
}

-(void) createWarriorInternal: (Warrior *) warrior {
    Warrior * copiedWarrior = [warrior copy];
    [_createdWarrior addObject:copiedWarrior];
    _currentRemainingHealthPoint -= [copiedWarrior healthPoint];
}

-(NSInteger) getWarriorIndex:(Warrior *) warrior {
    // http://stackoverflow.com/questions/110332/filtering-nsarray-into-a-new-nsarray-in-objective-c
    // http://stackoverflow.com/questions/14018645/objective-c-filter-out-results-from-nsmutablearray-by-a-dictionary-keys-value
    // method 1, using indexesOfObjectsPassingTest block
//    NSArray *specifiedWarrior = [[NSArray alloc] initWithArray:[_createdWarrior objectsAtIndexes:[_createdWarrior indexesOfObjectsPassingTest: ^BOOL(id obj, NSUInteger idx, BOOL *stop) {
//        return [obj warriorProfession] == [warrior warriorProfession];
//    }] ]copyItems:FALSE];
    // method 2, using predicateWithFormat
    NSArray *specifiedWarrior = [[NSArray alloc] initWithArray:[_createdWarrior filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"warriorProfession == %d", [warrior warriorProfession ]]] copyItems:FALSE];
    return [specifiedWarrior indexOfObject:warrior];
}

-(WarriorProfession) getNextWarriorProfession:(WarriorProfession) warriorProfession {
    NSInteger currentWarriorProfessionIndex = [_createWarriorSequence indexOfObject:[NSNumber numberWithInt:warriorProfession]];
    return [[_createWarriorSequence objectAtIndex:(currentWarriorProfessionIndex + 1) % [_createWarriorSequence count]] intValue];
}

@end
