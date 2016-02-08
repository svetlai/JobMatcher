//
//  JobOfferService.m
//  JobMatcher.iOS
//
//  Created by s i on 2/2/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

#import "JobOfferService.h"
#import "UserDataModel.h"
#import "GlobalConstants.h"
#import "AddJobOfferViewModel.h"

@implementation JobOfferService
NSString* const JobOfferRandomRoute = @"api/JobOffer/Random";
NSString* const JobOfferDeleteRoute = @"api/JobOffer/Delete";
NSString* const JobOfferAddRoute = @"api/JobOffer/Add";

NSString* authorizationTokenJobOffer;

-(instancetype) init {
    if (self = [super init]) {
        authorizationTokenJobOffer = [UserDataModel getToken];
    }
    
    return self;
}

-(void) getRandomOfferWithTarget:(NSObject*) target{
    NSString* url = [NSString stringWithFormat:@"%@%@", BaseUrl, JobOfferRandomRoute];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:authorizationTokenJobOffer forHTTPHeaderField:@"Authorization"];
    
    [NSURLConnection connectionWithRequest:request delegate:target];
}

-(void) addOfferWithModel:(AddJobOfferViewModel*)model andTarget:(NSObject*) target {
    
    NSString* url = [NSString stringWithFormat:@"%@%@", BaseUrl, JobOfferAddRoute];
    
    NSDictionary* postDataAsDict = @{@"RecruiterProfileId":[NSString stringWithFormat:@"%ld", model.recruiterProfileId],
                                     @"Title":model.title,
                                     @"Description":model.jobOfferDescription,
                                     @"Industry":[NSString stringWithFormat:@"%ld", model.indusry],
                                     @"WorkHours":[NSString stringWithFormat:@"%ld", model.workHours],
                                     @"Salary":[NSString stringWithFormat:@"%@", model.salary],
                                     @"Latitude":[NSString stringWithFormat:@"%f", model.latitude],
                                     @"Longitude":[NSString stringWithFormat:@"%f", model.longitude]};
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:authorizationTokenJobOffer forHTTPHeaderField:@"Authorization"];
    
    NSData* postData = [NSJSONSerialization dataWithJSONObject:postDataAsDict options:0 error:nil];
    
    [request setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:request delegate:target];
}

-(void) deleteOfferWithId: (NSInteger) id andTarget:(NSObject*) target{
    NSString* url = [NSString stringWithFormat:@"%@%@/%ld", BaseUrl, JobOfferDeleteRoute, id];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setValue:authorizationTokenJobOffer forHTTPHeaderField:@"Authorization"];
    
    [NSURLConnection connectionWithRequest:request delegate:target];
}

@end
