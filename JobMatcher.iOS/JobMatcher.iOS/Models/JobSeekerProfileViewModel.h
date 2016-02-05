//
//  JobSeekerProfileViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobSeekerProfileViewModel : NSObject
@property NSInteger profileId;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) NSString* summary;
@property (strong, nonatomic) NSArray* projects;
@property (strong, nonatomic) NSArray* skills;
@property (strong, nonatomic) NSArray* experience;
@property (strong, nonatomic) NSArray* education;
@property (strong, nonatomic) NSArray* selectedJobOffers;
@property (strong, nonatomic) NSArray* messages;
@property NSInteger profileType;

-(instancetype) initWithId:(NSInteger) profileId
                  andEmail:(NSString*) email
               andUsername:(NSString*) username
                andSummary:(NSString*) summary
               andProjects:(NSArray*) projects
                 andSkills:(NSArray*) skills
             andExperience:(NSArray*) experience
              andEducation:(NSArray*) education
      andSelectedJobOffers:(NSArray*)selectedJobOffers
               andMessages:(NSArray*)messages
            andProfileType:(NSInteger) profileType;

+(JobSeekerProfileViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary;

+(NSArray*) arrayOfJobOffersFromJsonDictionary: (NSArray*) jsonArray;
@end
