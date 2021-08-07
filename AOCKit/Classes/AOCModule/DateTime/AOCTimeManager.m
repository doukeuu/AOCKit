//
//  AOCTimeManager.m
//  AOCKit
//
//  Created by pan on 2021/8/4.
//

#import "AOCTimeManager.h"

@implementation AOCTimeManager

+ (void)timerForSecondCountDown:(NSTimeInterval)timeInterval
                         action:(void (^)(NSTimeInterval remainingTime, BOOL *stop))actionBlock
                     completion:(void (^)(void))completionBlock {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);

    __block BOOL isStop = NO;
    __block double interval = ABS(timeInterval);
    dispatch_source_set_event_handler(timer, ^{
        if (interval > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (actionBlock) actionBlock(interval, &isStop);
                if (isStop) dispatch_source_cancel(timer);
            });
            interval --;
        } else {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completionBlock) completionBlock();
            });
        }
    });
    dispatch_resume(timer);
}

@end
