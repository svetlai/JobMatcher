//
//  RecruiterService.h
//  JobMatcher.iOS
//
//  Created by s i on 1/31/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecruiterService : NSObject
-(void) getProfileWithTarget:(NSObject*) target;
-(void) getRecruiterMessagesWithJobSeekerId: (NSInteger) jobSeekerId andTarget:(NSObject*) target;
@end
