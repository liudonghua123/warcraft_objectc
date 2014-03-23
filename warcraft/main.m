//
//  main.m
//  warcraft
//
//  Created by 刘东华 on 3/22/14.
//  Copyright (c) 2014 刘东华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Warrior.h"
#import "Command.h"
#import "WarriorsHelper.h"
#import "Utils.h"

char *WarriorProfessionTypes[] = {
    "dragon",
    "ninja",
    "iceman",
    "lion",
    "wolf"
};
char *CommandTypes[] = { "red","blue" };

void initEnvironment(int totalHealthPoint, Command **redCommand_p, Command **blueCommand_p);
void makeWarriors(Command *redCommand, Command *blueCommand);
void printResult(Command *redCommand, Command *blueCommand);

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        int totalCase = 1, currentCase = 1;
        if(scanf("%d", &totalCase) != 1) {
            totalCase = 1;
        }
        while (currentCase <= totalCase) {
            int totalHealthPoint = 20;
            if(scanf("%d", &totalHealthPoint) != 1) {
                totalHealthPoint = 20;
            }
            Command *redCommand;
            Command *blueCommand;
            initEnvironment(totalHealthPoint, &redCommand, &blueCommand);
            
            printf("Case:%d\n", currentCase);
            makeWarriors(redCommand, blueCommand);
            printResult(redCommand, blueCommand);
            
            ++ currentCase;
        }
    }
    return 0;
}

void initEnvironment(int totalHealthPoint, Command **redCommand_p, Command **blueCommand_p)
{
    WarriorsHelper *warriorsHelper = [WarriorsHelper new];
    *redCommand_p = [[Command alloc] initWithTotalHealthPoint:totalHealthPoint commandType:RED warriorsHelper:warriorsHelper];
    *blueCommand_p = [[Command alloc] initWithTotalHealthPoint:totalHealthPoint commandType:BLUE warriorsHelper:warriorsHelper];
}

void makeWarriors(Command *redCommand, Command *blueCommand)
{
    BOOL redCommandCanCreate, blueCommandCanCreate;
    while (true) {
        redCommandCanCreate = [redCommand canCreateWarrior];
        blueCommandCanCreate = [blueCommand canCreateWarrior];
        
        if (!redCommandCanCreate && !blueCommandCanCreate) {
            break;
        }
        
        if (redCommandCanCreate) {
            [redCommand createWarrior];
        }
        if (blueCommandCanCreate) {
            [blueCommand createWarrior];
        }
    }
    
}

void printResult(Command *redCommand, Command *blueCommand)
{
    NSInteger redCount = [[redCommand createdWarrior] count];
    NSInteger blueCount = [[blueCommand createdWarrior] count];
    NSInteger maxCreatedWarriorsSize = redCount > blueCount ? redCount : blueCount;
    BOOL printedRedStops = false, printedBlueStops = false;
    for (NSInteger i = 0; i < maxCreatedWarriorsSize + 1; i++) {
        if (i < redCount) {
            Warrior* warrior = [[redCommand createdWarrior] objectAtIndex:i];
            printf(
                   "%03lu %s %s %lu born with strength %lu,%lu %s in %s headquarter\n",
                   i, CommandTypes[[redCommand commandType]],
                   WarriorProfessionTypes[[warrior warriorProfession]], i + 1,
                   [warrior healthPoint],
                   [redCommand getWarriorIndex :warrior] + 1,
                   WarriorProfessionTypes[[warrior warriorProfession]],
                   CommandTypes[[redCommand commandType]]);
        } else if (!printedRedStops) {
            printf("%03lu %s headquarter stops making warriors\n",
                   [[redCommand createdWarrior] count],
                   CommandTypes[[redCommand commandType]]);
            printedRedStops = true;
        }
        
        if (i < blueCount) {
            Warrior* warrior = [[blueCommand createdWarrior] objectAtIndex:i];
            printf(
                   "%03lu %s %s %lu born with strength %lu,%lu %s in %s headquarter\n",
                   i, CommandTypes[[blueCommand commandType]],
                   WarriorProfessionTypes[[warrior warriorProfession]], i + 1,
                   [warrior healthPoint],
                   [blueCommand getWarriorIndex :warrior] + 1,
                   WarriorProfessionTypes[[warrior warriorProfession]],
                   CommandTypes[[blueCommand commandType]]);
        } else if (!printedBlueStops) {
            printf("%03lu %s headquarter stops making warriors\n",
                   [[blueCommand createdWarrior] count],
                   CommandTypes[[blueCommand commandType]]);
            printedRedStops = true;
        }
    }
}


