//
//  JobSeekerProfileViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "JobSeekerProfileViewModel.h"
#import "ProjectViewModel.h"
#import "SkillViewModel.h"
#import "EducationViewModel.h"
#import "ExperienceViewModel.h"
#import "JobOfferViewModel.h"
#import "MessageViewModel.h"

@implementation JobSeekerProfileViewModel

-(instancetype) initWithId:(NSInteger) profileId
                  andEmail:(NSString*) email
               andUsername:(NSString*) username
                andSummary:(NSString*) summary
               andProjects:(NSArray*) projects
                 andSkills:(NSArray*) skills
             andExperience:(NSArray*) experience
              andEducation:(NSArray*) education
      andSelectedJobOffers:(NSArray*) selectedJobOffers
               andMessages:(NSArray*) messages
            andProfileType:(NSInteger) profileType
              andFirstName:(NSString*) firstName
               andLastName:(NSString*) lastName
            andPhoneNumber:(NSString*) phoneNumber
        andCurrentPosition:(NSString*) currentPosition{
    
    if (self = [super init]){
        self.profileId = profileId;
        self.email = email;
        self.username = username;
        self.summary = summary;
        self.projects = projects;
        self.skills = skills;
        self.experience = experience;
        self.education = education;
        self.selectedJobOffers = selectedJobOffers;
        self.messages = messages;
        self.profileType = profileType;
        self.firstName = firstName;
        self.lastName = lastName;
        self.phoneNumber = phoneNumber;
        self.currentPosition = currentPosition;
    }
    
    return self;

}

+(JobSeekerProfileViewModel*) fromJsonDictionary:(NSDictionary *)jsonDictionary{
    return [[JobSeekerProfileViewModel alloc]
            initWithId:[[jsonDictionary objectForKey:@"JobSeekerProfileId"] integerValue]
            andEmail:[jsonDictionary objectForKey:@"Email"]
            andUsername:[jsonDictionary objectForKey:@"Username"]
            andSummary:[jsonDictionary objectForKey:@"Summary"]
            andProjects:[ProjectViewModel arrayOfProjectsFromJsonDictionary:[jsonDictionary objectForKey:@"Projects"]]
            andSkills:[SkillViewModel arrayOfSkillsFromJsonDictionary:[jsonDictionary objectForKey:@"Skills"]]
            andExperience:[ExperienceViewModel arrayOfExperienceFromJsonDictionary:[jsonDictionary  objectForKey:@"Experience"]]
            andEducation:[EducationViewModel arrayOfEducationFromJsonDictionary:[jsonDictionary objectForKey:@"Education"]]
            andSelectedJobOffers:[JobOfferViewModel arrayOfJobOffersFromJsonDictionary:[jsonDictionary  objectForKey:@"SelectedJobOffers"]]
            andMessages:[MessageViewModel arrayOfMessagesFromJsonDictionary:[jsonDictionary objectForKey:@"Messages"]]
            andProfileType:[[jsonDictionary objectForKey:@"ProfileType"] integerValue]
            andFirstName:[jsonDictionary objectForKey:@"FirstName"]
            andLastName:[jsonDictionary objectForKey:@"LastName"]
            andPhoneNumber:[jsonDictionary objectForKey:@"PhoneNumber"]
            andCurrentPosition:[jsonDictionary objectForKey:@"CurrentPosition"]];
            ;
}

+(NSArray*) arrayOfJobOffersFromJsonDictionary: (NSArray*) jsonArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < jsonArray.count; i++) {
        [arr addObject:[JobSeekerProfileViewModel fromJsonDictionary:jsonArray[i]]];
    }
    
    return [NSArray arrayWithArray:arr];
}

@end
