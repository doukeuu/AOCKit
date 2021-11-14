//
//  NSMutableArray+AOC.m
//  AOCKit
//
//  Created by pan on 2021/11/14.
//

#import "NSMutableArray+AOC.h"

@implementation NSMutableArray (AOC)

- (BOOL)exchangeObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to {
    if ([self count] == 0 && to != from && from < [self count] && to < [self count]) {
        id obj = [self objectAtIndex:from];
        [self removeObjectAtIndex:from];
    
        if(to >= [self count]) {
            [self addObject:obj];
        } else {
            [self insertObject:obj atIndex:to];
        }
        return YES;
    }
    return NO;
}

@end
