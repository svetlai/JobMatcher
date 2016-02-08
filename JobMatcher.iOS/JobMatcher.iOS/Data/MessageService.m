//
//  MessageService.m
//  JobMatcher.iOS
//
//  Created by s i on 2/7/16.
//  Copyright © 2016 svetlai. All rights reserved.
//
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#import "MessageService.h"
#import "UserDataModel.h"
#import "AddMessageViewModel.h"
#import "GlobalConstants.h"

@implementation MessageService

NSString* const MessageAddRoute = @"api/Message/Add";

NSString* authorizationTokenMessage;

-(instancetype) init {
    if (self = [super init]) {
        authorizationTokenMessage = [UserDataModel getToken];
    }
    
    return self;
}

-(void) addMessageWithModel:(AddMessageViewModel*)model andTarget:(NSObject*) target {
    
    NSString* url = [NSString stringWithFormat:@"%@%@", BaseUrl, MessageAddRoute];
    NSString* senderId = @"0";
    
    NSDictionary* postDataAsDict = @{@"RecruiterProfileId":[NSString stringWithFormat:@"%ld", model.recruiterProfileId],
                                     @"JobSeekerProfileId":[NSString stringWithFormat:@"%ld", model.jobSeekerProfileId],
                                     @"SenderProfileType":model.senderAccountType,
                                     @"SenderId":senderId,
                                     @"Subject":model.messageSubject,
                                     @"Content":model.messageContent};
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:authorizationTokenMessage forHTTPHeaderField:@"Authorization"];
    
    NSData* postData = [NSJSONSerialization dataWithJSONObject:postDataAsDict options:0 error:nil];
    
    [request setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:request delegate:target];
}

@end
