//
//  GlobalConstants.m
//  JobMatcher.iOS
//
//  Created by s i on 1/24/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "GlobalConstants.h"

@implementation GlobalConstants

NSString* const AppName = @"Job Matcher";
NSString* const BaseUrl = @"http://svetlapc:61177/";
NSString* const JobMatcherDb = @"JobMatcherDb";

// Account
NSString* const KeyChainTokenKey = @"access_token";
NSString* const KeyChainUsernameKey = @"profile_type";
NSString* const KeyChainProfileTypeKey = @"userName";
NSString* const KeyChainProfileIdKey = @"profile_id";

NSString* const NotConnectedMessage = @"You're not connected to the Internet.";

NSArray* AccountTypes;
NSArray* Industries;
NSArray* WorkHours;
NSArray* Degree;
NSArray* Level;

+(void)fillArrays{
    AccountTypes = [[NSArray alloc] initWithObjects:@"Job Seeker", @"Recruiter", nil];
    Industries = [[NSArray alloc] initWithObjects:@"Accountancy Banking Finance", @"Business Consulting And Management",
                      @"Charity And Voluntary Work", @"Creative Arts And Design",
                      @"Energy And Utilities", @"Engineering And Manufacturing",
                      @"Environment And Agriculture", @"Healthcare", @"Hospitality",
                      @"Information Technology", @"Law",
                      @"Law Enforcement And Security", @"Leisure Sports And Tourism",
                      @"Marketing Advertising And PR", @"Media And Internet",
                      @"Property And Construction", @"Public Services And Admin",
                      @"Recruitment And HR", @"Retail",
                      @"Sales", @"Science And Pharmaceuticals",
                      @"Social Care", @"Teaching And Education",
                      @"Transport AndLogistics",nil];
    
    WorkHours = [[NSArray alloc] initWithObjects:@"Full-Time", @"Part-Time", nil];
    
    Degree = [[NSArray alloc] initWithObjects:@"Bachelor", @"Master", @"HighSchool", @"Other", nil];

    Level = [[NSArray alloc] initWithObjects:@"NotApplicable", @"Fundamental", @"Novice", @"Intermediate", @"Advanced", @"Expert", nil];
}

@end