//
//  RecruiterService.m
//  JobMatcher.iOS
//
//  Created by s i on 1/31/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

#import "RecruiterService.h"
#import "UserDataModel.h"
#import "GlobalConstants.h"

@implementation RecruiterService
NSString* const RecruiterDetailsRoute = @"api/recruiterprofile/details";
NSString* const MessagesWithJobSeekerRoute = @"api/recruiterprofile/GetMessagesWithJobSeeker";

NSString* authorizationTokenRecruiter;

-(instancetype) init {
    if (self = [super init]) {
        authorizationTokenRecruiter = [UserDataModel getToken];
    }
    
    return self;
}

-(void) getProfileWithTarget:(NSObject*) target{
    
    NSString* url = [NSString stringWithFormat:@"%@%@", BaseUrl, RecruiterDetailsRoute];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:authorizationTokenRecruiter forHTTPHeaderField:@"Authorization"];
    
    [NSURLConnection connectionWithRequest:request delegate:target];
}

-(void) getRecruiterMessagesWithJobSeekerId: (NSInteger) jobSeekerId andTarget:(NSObject*) target{
    
    NSString* url = [NSString stringWithFormat:@"%@%@?jobSeekerProfileId=%ld", BaseUrl, MessagesWithJobSeekerRoute, jobSeekerId];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:authorizationTokenRecruiter forHTTPHeaderField:@"Authorization"];
    
    [NSURLConnection connectionWithRequest:request delegate:target];
}


@end
