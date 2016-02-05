//
//  RecruiterProfileViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 2/1/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecruiterProfileViewModel : NSObject
@property NSInteger profileId;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) NSArray* jobOffers;
@property (strong, nonatomic) NSArray* messages;
@property (strong, nonatomic) NSArray* matchedJobSeekers;
@property NSInteger profileType;

-(instancetype) initWithId:(NSInteger) profileId
                  andEmail:(NSString*) email
               andUsername:(NSString*) username
               andJobOffers:(NSArray*) jobOffers
               andMessages:(NSArray*) messages
      andMatchedJobSeekers:(NSArray*) matchedJobSeekers
            andProfileType:(NSInteger) profileType;

+(RecruiterProfileViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary;

@end
