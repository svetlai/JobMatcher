//
//  JobSeekerService.h
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddProjectViewModel.h"
#import "AddSkillViewModel.h"
#import "EditJobSeekerProfileViewModel.h"

@interface JobSeekerService : NSObject
-(void) getProfileWithTarget:(NSObject*) target;
-(void) getRandomProfileWithTarget:(NSObject*) target;
-(void) getJobSeekerMessagesWithRecruiterId: (NSInteger) recruiterId andTarget:(NSObject*) target;
-(void) addProjectWithModel:(AddProjectViewModel*)model andTarget:(NSObject*) target;
-(void) deleteProjectWithId: (NSInteger) id andTarget:(NSObject*) target;
-(void) addSkillWithModel:(AddSkillViewModel*)model andTarget:(NSObject*) target;
-(void) deleteSkillWithId: (NSInteger) id andTarget:(NSObject*) target;
-(void) editProfileWithModel:(EditJobSeekerProfileViewModel*)model andTarget:(NSObject*) target;
-(void) getEditProfileWithId: (NSInteger) id andTarget:(NSObject*) target;
@end
