//
//  JobSeekerService.h
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddProjectViewModel.h"

@interface JobSeekerService : NSObject
-(void) getProfileWithTarget:(NSObject*) target;
-(void) getRandomProfileWithTarget:(NSObject*) target;
-(void) getJobSeekerMessagesWithRecruiterId: (NSInteger) recruiterId andTarget:(NSObject*) target;
-(void) addProjectWithModel:(AddProjectViewModel*)model andTarget:(NSObject*) target;
-(void) deleteProjectWithId: (NSInteger) id andTarget:(NSObject*) target;
@end
