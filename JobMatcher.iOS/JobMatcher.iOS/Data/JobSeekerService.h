//
//  JobSeekerService.h
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobSeekerService : NSObject
-(void) getProfileWithTarget:(NSObject*) target;
-(void) getRandomProfileWithTarget:(NSObject*) target;
@end
