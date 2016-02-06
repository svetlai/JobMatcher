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

@implementation JobSeekerService

NSString* const DetailsRoute = @"api/jobseekerprofile/details";
NSString* const RandomRoute = @"api/jobseekerprofile/random";
NSString* const MessagesWithRecruiterRoute = @"api/jobseekerprofile/GetMessagesWithRecruiter";

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

@end
