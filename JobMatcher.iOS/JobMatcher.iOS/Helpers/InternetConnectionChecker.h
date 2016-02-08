//
//  InternetConnectionChecker.h
//  JobMatcher.iOS
//
//  Created by s i on 1/24/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

@interface InternetConnectionChecker : NSObject

-(NSString *)getConnectionSatus;
extern NSString* const NotConnectedStatus;
extern NSString* const ConnectedStatus;
@end
