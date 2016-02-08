//
//  RecruiterProfileViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 2/1/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "RecruiterProfileViewModel.h"
#import "JobOfferViewModel.h"
#import "MessageViewModel.h"
#import "JobSeekerProfileViewModel.h"

@implementation RecruiterProfileViewModel
-(instancetype) initWithId:(NSInteger) profileId
                  andEmail:(NSString*) email
               andUsername:(NSString*) username
              andJobOffers:(NSArray*) jobOffers
               andMessages:(NSArray*) messages
      andMatchedJobSeekers:(NSArray*) matchedJobSeekers
            andProfileType:(NSInteger) profileType{
    
    if (self = [super init]){
        self.profileId = profileId;
        self.email = email;
        self.username = username;
        self.jobOffers = jobOffers;
        self.messages = messages;
        self.matchedJobSeekers = matchedJobSeekers;
        self.profileType = profileType;
    }
    
    return self;
}


+(RecruiterProfileViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary{
    return [[RecruiterProfileViewModel alloc]
            initWithId:[[jsonDictionary objectForKey:@"RecruiterProfileId"] integerValue]
            andEmail:[jsonDictionary objectForKey:@"Email"]
            andUsername:[jsonDictionary objectForKey:@"Username"]
            andJobOffers:[JobOfferViewModel arrayOfJobOffersFromJsonDictionary:[jsonDictionary objectForKey:@"JobOffers"]]
            andMessages:[MessageViewModel arrayOfMessagesFromJsonDictionary:[jsonDictionary objectForKey:@"Messages"]]
            andMatchedJobSeekers:[JobSeekerProfileViewModel arrayOfJobOffersFromJsonDictionary:[jsonDictionary objectForKey:@"MatchedJobSeekers"]]
            andProfileType:[[jsonDictionary objectForKey:@"ProfileType"] integerValue]];
}
@end
