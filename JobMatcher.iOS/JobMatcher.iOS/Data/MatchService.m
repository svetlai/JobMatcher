//
//  MatchService.m
//  JobMatcher.iOS
//
//  Created by s i on 1/31/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "MatchService.h"
#import "UserDataModel.h"
#import "GlobalConstants.h"
#import "AddLikeViewModel.h"
#import "AddDislikeViewModel.h"

@implementation MatchService
NSString* const AddLikeRoute = @"api/like/add";
NSString* const AddDislikeRoute = @"api/dislike/add";

NSString* authorizationTokenMatch;

-(instancetype) init {
    if (self = [super init]) {
        authorizationTokenMatch = [UserDataModel getToken];
    }
    
    return self;
}

-(void) addLikeWithModel:(AddLikeViewModel*)model andTarget:(NSObject*) target {
    NSString* url = [NSString stringWithFormat:@"%@%@", BaseUrl, AddLikeRoute];
    NSString* recruiterProfileId = @"0";
    NSString* jobSeekerProfileId = @"0";
    NSString* jobOfferId = @"0";

    if ([model.myAccountType isEqualToString:[NSString stringWithFormat:@"%u", JobSeeker]]){
        recruiterProfileId = model.likedId;
        jobOfferId = model.jobOfferId;
    } else if ([model.myAccountType isEqualToString:[NSString stringWithFormat:@"%u", Recruiter]]){
        jobSeekerProfileId = model.likedId;
    }
    
    NSDictionary* postDataAsDict = @{@"RecruiterProfileId":recruiterProfileId,
                                     @"JobSeekerProfileId":jobSeekerProfileId,
                                     @"LikeInitiatorType":model.myAccountType,
                                     @"JobOfferId":jobOfferId};
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:authorizationTokenMatch forHTTPHeaderField:@"Authorization"];
    
    NSData* postData = [NSJSONSerialization dataWithJSONObject:postDataAsDict options:0 error:nil];
    
    [request setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:request delegate:target];
}

-(void) addDislikeWithModel:(AddDislikeViewModel*)model andTarget:(NSObject*) target {
    NSString* url = [NSString stringWithFormat:@"%@%@", BaseUrl, AddDislikeRoute];
    NSString* recruiterProfileId = @"0";
    NSString* jobSeekerProfileId = @"0";
    NSString* jobOfferId = @"0";
 
    if ([model.myAccountType isEqualToString:[NSString stringWithFormat:@"%u", JobSeeker]]){
        recruiterProfileId = model.dislikedId;
        jobOfferId = model.jobOfferId;
    } else if ([model.myAccountType isEqualToString:[NSString stringWithFormat:@"%u", Recruiter]]){
        jobSeekerProfileId = model.dislikedId;
    }
    
    NSDictionary* postDataAsDict = @{@"RecruiterProfileId":recruiterProfileId,
                                     @"JobSeekerProfileId":jobSeekerProfileId,
                                     @"DislikeInitiatorType":model.myAccountType,
                                     @"JobOfferId":jobOfferId};
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:authorizationTokenMatch forHTTPHeaderField:@"Authorization"];
    
    NSData* postData = [NSJSONSerialization dataWithJSONObject:postDataAsDict options:0 error:nil];
    
    [request setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:request delegate:target];
}

@end
