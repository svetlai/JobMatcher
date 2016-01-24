//
//  HttpRequester.m
//  JobMatcher.iOS
//
//  Created by s i on 1/24/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "HttpRequester.h"

@implementation HttpRequester {
    NSString* baseUrl;
}

-(instancetype) initWithBaseUrl: (NSString*)theBaseUrl{
    if (self=[super init]) {
        baseUrl = theBaseUrl;
    }
    return self;
}

+(HttpRequester*) requesterWithBaseUrl:(NSString*) baseUrl {
    return [[HttpRequester alloc] initWithBaseUrl:baseUrl];
}


-(void)createRequest: (NSString*) method atUrl: (NSString*) url data: (NSData*)
data headers: (NSDictionary*) headers withTarget: (NSObject*) target andAuthorization:(NSString*) authorization{
    NSString* fullUrl = [NSString stringWithFormat:@"%@%@", baseUrl, url];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    
    [request setHTTPMethod:method];
    
    if (headers) {
        for(id key in headers) {
            [request setValue:[headers objectForKey:key] forHTTPHeaderField:key];
        }
    }
    else {
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    
    if (authorization) {
        [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    }
    
    if (data) {
        [request setHTTPBody:data];
    }
    
    [NSURLConnection connectionWithRequest:request delegate: target];
}

-(void) get: (NSString*) url headers: (NSDictionary*) headers withTarget: (NSObject*) target
andAuthorization:(NSString*) authorization{
    [self createRequest:@"GET" atUrl:url data:nil headers:headers withTarget:target andAuthorization: authorization];
}

-(void) post: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target andAuthorization:(NSString*) authorization{
    [self createRequest:@"POST" atUrl:url data:data headers:headers withTarget:target andAuthorization: authorization];
}

-(void) put: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target  andAuthorization:(NSString*) authorization{
    [self createRequest:@"PUT" atUrl:url data:data headers:headers withTarget:target andAuthorization: authorization];
}

-(void) delete: (NSString*) url data: (NSData*) data headers: (NSDictionary*) headers withTarget: (NSObject*) target andAuthorization:(NSString*) authorization{
    [self createRequest:@"DELETE" atUrl:url data:data headers:headers withTarget:target andAuthorization: authorization];
}

@end
