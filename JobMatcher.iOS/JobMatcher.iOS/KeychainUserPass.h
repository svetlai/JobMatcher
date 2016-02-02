//
//  KeychainUserPass.h
//  JobMatcher.iOS
//
//  Created by s i on 1/26/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface KeychainUserPass : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

@end
