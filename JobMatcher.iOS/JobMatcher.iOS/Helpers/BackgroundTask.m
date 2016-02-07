//
//  BackgroundTask.m
//  JobMatcher.iOS
//
//  Created by s i on 2/7/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "BackgroundTask.h"
#import "InternetConnectionChecker.h"
#import "HelperMethods.h"
#import "GlobalConstants.h"

@implementation BackgroundTask
static InternetConnectionChecker *internetCheker;

-(instancetype)init{
    if (self=[super init]){
        internetCheker = [[InternetConnectionChecker alloc] init];
    }
    
    return self;
}

-(void) run {
    UIApplication * application = [UIApplication sharedApplication];
    
    if([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
    {
        NSLog(@"Multitasking Supported");
        
        __block UIBackgroundTaskIdentifier background_task;
        background_task = [application beginBackgroundTaskWithExpirationHandler:^ {
            
            //Clean up code. Tell the system that we are done.
            [application endBackgroundTask: background_task];
            background_task = UIBackgroundTaskInvalid;
        }];
        
        //To make the code block asynchronous
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            //### background task starts
            NSLog(@"Running in the background\n");
            while(TRUE)
            {
                [self checkInternetConnection];
//                NSLog(@"Background time Remaining: %f",[[UIApplication sharedApplication] backgroundTimeRemaining]);
                [NSThread sleepForTimeInterval:1 * 60 * 10]; //wait for 10 minutes
            }
            //#### background task ends
            
            //Clean up code. Tell the system that we are done.
            [application endBackgroundTask: background_task];
            background_task = UIBackgroundTaskInvalid; 
        });
    }
    else
    {
        NSLog(@"Multitasking Not Supported");
    }
}

-(void)checkInternetConnection{
    NSString *status = [internetCheker getConnectionSatus];
    
    if ([status isEqualToString:NotConnectedStatus]) {
        [HelperMethods addAlert:NotConnectedMessage];
    }
}
@end
