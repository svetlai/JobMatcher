//
//  AccountService.m
//  JobMatcher.iOS
//
//  Created by s i on 1/25/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

#import "AccountService.h"
#import "GlobalConstants.h"
#import "KeychainUserPass.h"

@implementation AccountService

NSString* const RegisterRoute = @"api/account/register";
NSString* const LoginRoute = @"Token";

//-(instancetype) init {
//    if (self = [super init]) {
//        self.authorizationToken = nil;
//        self.loggedUserName = nil;
//    }
//    
//    return self;
//}

-(void) registerUserWithEmail: (NSString*) email andPassword: (NSString*) password andProfileType: (NSString*) profileType andTarget:(NSObject*) target{
    
    NSString* url = [NSString stringWithFormat:@"%@%@", BaseUrl, RegisterRoute];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
//        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSString *postString = [NSString stringWithFormat:@"Email=%@&Password=%@&ConfirmPassword=%@&ProfileType=%@",email,password,password,profileType];
    
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];

        [request setHTTPBody:postData];
        [NSURLConnection connectionWithRequest:request delegate:target];
}

-(void) loginUserWithEmail: (NSString*) email andPassword: (NSString*) password andTarget:(NSObject*) target{
    
    NSString* url = [NSString stringWithFormat:@"%@%@", BaseUrl, LoginRoute];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    
    NSString *postString = [NSString stringWithFormat:@"Username=%@&Password=%@&Grant_Type=password",email,password];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];

    [request setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:request delegate:target];
}

-(void) logout{
    [KeychainUserPass delete:KeyChainTokenKey];
    [KeychainUserPass delete:KeyChainProfileTypeKey];
    [KeychainUserPass delete:KeyChainUsernameKey];
}
@end
