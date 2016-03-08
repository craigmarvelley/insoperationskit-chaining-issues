//
//  AppDelegate.m
//  insoperation-chaining-issues
//
//  Created by Craig Marvelley on 08/03/2016.
//  Copyright © 2016 marvelley. All rights reserved.
//

#import "AppDelegate.h"
#import <INSOperationsKit/INSOperationsKit.h>

@interface AppDelegate ()

@property (strong, nonatomic) INSOperationQueue *queue;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    INSOperationQueue *queue = [[INSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    
    queue.suspended = YES;
    
    for (int i=0; i<100; i++) {
        
        INSBlockOperation *op1 = [INSBlockOperation operationWithBlock:^(INSBlockOperationCompletionBlock  _Nonnull completionBlock) {
            sleep(0.5);
            completionBlock();
        }];
        
        INSBlockOperation *op2 = [INSBlockOperation operationWithBlock:^(INSBlockOperationCompletionBlock  _Nonnull completionBlock) {
            sleep(0.5);
            completionBlock();
        }];
        
        INSBlockOperation *op3 = [INSBlockOperation operationWithBlock:^(INSBlockOperationCompletionBlock  _Nonnull completionBlock) {
            sleep(0.5);
            NSLog(@"%@ remaining", @(queue.operationCount));
            completionBlock();
        }];
        
        INSChainOperation *chain = [INSChainOperation operationWithOperations:@[op1, op2, op3]];
        
        [queue addOperation:chain];
        
    }
    
    self.queue = queue;
    
    NSLog(@"%@ operations queued", @(queue.operationCount));
    
    queue.suspended = NO;
    
    return YES;
}

@end
