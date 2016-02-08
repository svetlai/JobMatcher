//
//  JobSeekerService.m
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

#import "JobSeekerService.h"
#import "GlobalConstants.h"
#import "UserDataModel.h"
#import "AddProjectViewModel.h"
#import "AddSkillViewModel.h"
#import "EditJobSeekerProfileViewModel.h"

@implementation JobSeekerService

NSString* const DetailsRoute = @"api/jobseekerprofile/details";
NSString* const RandomRoute = @"api/jobseekerprofile/random";
NSString* const MessagesWithRecruiterRoute = @"api/jobseekerprofile/GetMessagesWithRecruiter";
NSString* const AddProjectRoute = @"api/project/add";
NSString* const DeleteProjectRoute = @"api/project/delete";
NSString* const AddSkillRoute = @"api/skill/add";
NSString* const DeleteSkillRoute = @"api/skill/delete";
NSString* const EditProfileRoute = @"api/jobseekerprofile/edit";

NSString* authorizationToken;

-(instancetype) init {
    if (self = [super init]) {
        authorizationToken = [UserDataModel getToken];
    }

    return self;
}

-(void) getProfileWithTarget:(NSObject*) target{
    
    NSString* url = [NSString stringWithFormat:@"%@%@", BaseUrl, DetailsRoute];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:authorizationToken forHTTPHeaderField:@"Authorization"];
    
    [NSURLConnection connectionWithRequest:request delegate:target];
}

-(void) getRandomProfileWithTarget:(NSObject*) target{
    
    NSString* url = [NSString stringWithFormat:@"%@%@", BaseUrl, RandomRoute];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:authorizationToken forHTTPHeaderField:@"Authorization"];
    
    [NSURLConnection connectionWithRequest:request delegate:target];
}

-(void) getJobSeekerMessagesWithRecruiterId: (NSInteger) recruiterId andTarget:(NSObject*) target{
    
    NSString* url = [NSString stringWithFormat:@"%@%@?recruiterProfileId=%ld", BaseUrl, MessagesWithRecruiterRoute, recruiterId];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:authorizationToken forHTTPHeaderField:@"Authorization"];
    
    [NSURLConnection connectionWithRequest:request delegate:target];
}

-(void) addProjectWithModel:(AddProjectViewModel*)model andTarget:(NSObject*) target {
    
    NSString* url = [NSString stringWithFormat:@"%@%@", BaseUrl, AddProjectRoute];
    
    NSDictionary* postDataAsDict = @{@"Title":model.title,
                                     @"Description":model.projectDescription,
                                     @"Url":model.url};
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:authorizationToken forHTTPHeaderField:@"Authorization"];
    
    NSData* postData = [NSJSONSerialization dataWithJSONObject:postDataAsDict options:0 error:nil];
    
    [request setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:request delegate:target];
}

-(void) deleteProjectWithId: (NSInteger) id andTarget:(NSObject*) target{
    NSString* url = [NSString stringWithFormat:@"%@%@/%ld", BaseUrl, DeleteProjectRoute, id];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:authorizationToken forHTTPHeaderField:@"Authorization"];
    
    [NSURLConnection connectionWithRequest:request delegate:target];
}

-(void) addSkillWithModel:(AddSkillViewModel*)model andTarget:(NSObject*) target {
    
    NSString* url = [NSString stringWithFormat:@"%@%@", BaseUrl, AddSkillRoute];
    
    NSDictionary* postDataAsDict = @{@"Name":model.name,
                                     @"Level":[NSString stringWithFormat:@"%ld", model.level]};
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:authorizationToken forHTTPHeaderField:@"Authorization"];
    
    NSData* postData = [NSJSONSerialization dataWithJSONObject:postDataAsDict options:0 error:nil];
    
    [request setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:request delegate:target];
}

-(void) deleteSkillWithId: (NSInteger) id andTarget:(NSObject*) target{
    NSString* url = [NSString stringWithFormat:@"%@%@/%ld", BaseUrl, DeleteSkillRoute, id];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:authorizationToken forHTTPHeaderField:@"Authorization"];
    
    [NSURLConnection connectionWithRequest:request delegate:target];
}

-(void) editProfileWithModel:(EditJobSeekerProfileViewModel*)model andTarget:(NSObject*) target {
    
    NSInteger profileID = model.profileId;
    
    NSString* url = [NSString stringWithFormat:@"%@%@/%ld", BaseUrl, EditProfileRoute, profileID];
    
    NSDictionary* postDataAsDict = @{@"FirstName":model.firstName,
                                     @"LastName":model.lastName,
                                      @"Summary":model.summary,
                                      @"LastName":model.currentPosition,
                                      @"PhoneNumber":model.phoneNumber};
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:authorizationToken forHTTPHeaderField:@"Authorization"];
    
    NSData* postData = [NSJSONSerialization dataWithJSONObject:postDataAsDict options:0 error:nil];
    
    [request setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:request delegate:target];
}

-(void) getEditProfileWithId: (NSInteger) id andTarget:(NSObject*) target{
    
   NSString* url = [NSString stringWithFormat:@"%@%@/%ld", BaseUrl, EditProfileRoute, id];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:authorizationToken forHTTPHeaderField:@"Authorization"];
    
    [NSURLConnection connectionWithRequest:request delegate:target];
}


@end
