//
//  UserDataModel.m
//  JobMatcher.iOS
//
//  Created by s i on 1/25/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "UserDataModel.h"
#import "KeychainUserPass.h"
#import "GlobalConstants.h"

@implementation UserDataModel

//NSString* const KeyChainTokenKey = @"access_token";
//NSString* const KeyChainUsernameKey = @"profile_type";
//NSString* const KeyChainProfileTypeKey = @"userName";

-(instancetype) init{
    if (self=[super init]) {
        NSString* token = [KeychainUserPass load:KeyChainTokenKey];
        NSString* profileType = [KeychainUserPass load:KeyChainProfileTypeKey];
        NSString* username = [KeychainUserPass load:KeyChainUsernameKey];
        
        self.token = token;
        self.username = username;
        self.profileType = [UserDataModel accountTypeEnumFromString: profileType];
    }
    
    return self;
}

+(BOOL)isLoggedIn{
    NSString* token = [KeychainUserPass load:KeyChainTokenKey];
    return token.length > 0;
}

+(NSString*)getToken{
    return [KeychainUserPass load:KeyChainTokenKey];
}

+(AccountType)getAccountType{
    NSString* profileType = [KeychainUserPass load:KeyChainProfileTypeKey];
    return [UserDataModel accountTypeEnumFromString: profileType];
}

-(void)logout{
    [KeychainUserPass delete:KeyChainTokenKey];
    [KeychainUserPass delete:KeyChainProfileTypeKey];
    [KeychainUserPass delete:KeyChainUsernameKey];
    self.token = nil;
    self.username = nil;
    self.profileType = -1;
}

+(AccountType)accountTypeEnumFromString: (NSString*) str{
    NSDictionary<NSString*,NSNumber*> *accountTypes = @{
                                                  @"JobSeeker": @(JobSeeker),
                                                  @"Recruiter": @(Recruiter),
                                                  };
    return accountTypes[str].integerValue;
}


@end
