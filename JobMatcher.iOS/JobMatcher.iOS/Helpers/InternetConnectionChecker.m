//
//  InternetConnectionChecker.m
//  JobMatcher.iOS
//
//  Created by s i on 1/24/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "InternetConnectionChecker.h"

@implementation InternetConnectionChecker
NSString* const NotConnectedStatus = @"Not connected";
NSString* const ConnectedStatus = @"Connected";

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

-(NSString *)getConnectionSatus{
    Reachability* networkReachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
        return NotConnectedStatus;
    } else {
        return ConnectedStatus;
    }
}
@end
