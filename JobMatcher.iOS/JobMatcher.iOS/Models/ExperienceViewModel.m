//
//  ExperienceViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "ExperienceViewModel.h"
#import "HelperMethods.h"
@implementation ExperienceViewModel

-(instancetype) initWithId:(NSInteger) experienceId
               andPosition:(NSString*) position
           andOrganization:(NSString*) organization
            andDescription:(NSString*) experienceDescription
              andStartDate:(NSDate*) startDate
                andEndDate:(NSDate*) endDate
               andIndustry:(NSInteger) industry{
    if (self = [super init]){
        self.experienceId = experienceId;
        self.position = position;
        self.organization = organization;
        self.experienceDescription = experienceDescription;
        self.startDate = startDate;
        self.endDate = endDate;
        self.industry = industry;
    }
    
    return self;
}


+(ExperienceViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary{
    NSDate* startDate = [HelperMethods getDateFromString:[jsonDictionary objectForKey:@"StartDate"]];
    NSDate* endDate = [HelperMethods getDateFromString:[jsonDictionary objectForKey:@"EndDate"]];
    
        return [[ExperienceViewModel alloc]
             initWithId:[[jsonDictionary objectForKey:@"Id"] integerValue]
             andPosition:[jsonDictionary objectForKey:@"Position"]
             andOrganization:[jsonDictionary objectForKey:@"OrganizationName"]
             andDescription:[jsonDictionary objectForKey:@"Description"]
             andStartDate:startDate
             andEndDate:endDate
             andIndustry:[[jsonDictionary objectForKey:@"Industry"] integerValue]];
}

+(NSArray*) arrayOfExperienceFromJsonDictionary: (NSArray*) jsonArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < jsonArray.count; i++) {
        [arr addObject:[ExperienceViewModel fromJsonDictionary:jsonArray[i]]];
    }
    
    return [NSArray arrayWithArray:arr];
}






@end
