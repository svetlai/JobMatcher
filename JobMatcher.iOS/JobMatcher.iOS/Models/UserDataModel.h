//
//  UserDataModel.h
//  JobMatcher.iOS
//
//  Created by s i on 1/25/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    JobSeeker = 0,
    Recruiter = 1
} AccountType;

@interface UserDataModel : NSObject

@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) NSString* token;
@property AccountType profileType;
@property NSInteger profileId;

+(BOOL)isLoggedIn;
+(NSString*)getToken;
+(AccountType)getAccountType;
+(AccountType)accountTypeEnumFromString: (NSString*) str;
@end
