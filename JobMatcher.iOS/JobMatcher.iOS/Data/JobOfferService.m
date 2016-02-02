//
//  JobOfferService.m
//  JobMatcher.iOS
//
//  Created by s i on 2/2/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "JobOfferService.h"
#import "UserDataModel.h"
#import "GlobalConstants.h"

@implementation JobOfferService
NSString* const JobOfferRandomRoute = @"api/JobOffer/Random";

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

@end
