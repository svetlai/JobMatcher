//
//  JobOfferViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "JobOfferViewModel.h"
#import "JobSeekerProfileViewModel.h"

@implementation JobOfferViewModel
-(instancetype) initWithId:(NSInteger) jobOfferId
                  andTitle:(NSString*) title
               andLocation:(NSString*) location
            andDescription:(NSString*) jobOfferDescription
               andIndustry:(NSInteger) industry
                 andSalary:(double) salary
              andWorkHours:(NSInteger)workHours
     andRecruiterProfileId:(NSInteger)recruiterProfileId
    andInteresteJobSeekers:(NSArray*) interestedJobSeekers
              andIsDeleted:(BOOL) isDeleted{
    
    if (self = [super init]){
        self.jobOfferId = jobOfferId;
        self.title = title;
        self.location = location;
        self.jobOfferDescription = jobOfferDescription;
        self.industry = industry;
        self.salary = salary;
        self.workHours = workHours;
        self.recruiterProfileId = recruiterProfileId;
        self.interestedJobSeekers = interestedJobSeekers;
        self.isDeleted = isDeleted;
    }
    
    return self;
}

+(JobOfferViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary{
    return [[JobOfferViewModel alloc]
            initWithId:[[jsonDictionary objectForKey:@"Id"] integerValue]
            andTitle:[jsonDictionary objectForKey:@"Title"]
            andLocation:[jsonDictionary objectForKey:@"Location"]
            andDescription:[jsonDictionary objectForKey:@"Description"]
            andIndustry:[[jsonDictionary objectForKey:@"Industry"] integerValue]
            andSalary:[[jsonDictionary objectForKey:@"Salary"] doubleValue]
            andWorkHours:[[jsonDictionary objectForKey:@"WorkHours"] integerValue]
            andRecruiterProfileId:[[jsonDictionary objectForKey:@"RecruiterProfileId"] integerValue]
            andInteresteJobSeekers:[JobSeekerProfileViewModel arrayOfJobOffersFromJsonDictionary:[jsonDictionary objectForKey:@"InteresteJobSeekers"]]
            andIsDeleted:[[jsonDictionary objectForKey:@"IsDeleted"] boolValue]];
}

+(NSArray*) arrayOfJobOffersFromJsonDictionary: (NSArray*) jsonArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < jsonArray.count; i++) {
        [arr addObject:[JobOfferViewModel fromJsonDictionary:jsonArray[i]]];
    }
    
    return [NSArray arrayWithArray:arr];
}
@end
