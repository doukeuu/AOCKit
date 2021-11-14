//
//  NSArray+AOC.m
//  AOCKit
//
//  Created by pan on 2021/11/14.
//

#import "NSArray+AOC.h"

@implementation NSArray (AOC)

- (NSArray *)reversedArray {
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [arrayTemp addObject:element];
    }
    return [arrayTemp copy];
}

- (NSString *)toJSONString {
    if (self.count == 0) {
        return @"";
    }
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    if (error) {
        return nil;
    } else {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
}

@end
