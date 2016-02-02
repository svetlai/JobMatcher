//
//  EducationViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "EducationViewModel.h"
#import "HelperMethods.h"

@implementation EducationViewModel

-(instancetype) initWithId:(NSInteger) educationId
                 andDegree:(NSInteger) degree
              andSpecialty:(NSString*) specialty
           andOrganization:(NSString*) organization
            andDescription:(NSString*) educationDescription
              andStartDate:(NSDate*) startDate
                andEndDate:(NSDate*) endDate
               andIndustry:(NSInteger) industry{
    if (self = [super init]){
        self.educationId = educationId;
        self.degree = degree;
        self.specialty = specialty;
        self.organization = organization;
        self.educationDescription = educationDescription;
        self.startDate = startDate;
        self.endDate = endDate;
        self.industry = industry;
    }
    
    return self;
}

+(EducationViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary{
    NSDate* startDate = [HelperMethods getDateFromString:[jsonDictionary objectForKey:@"StartDate"]];
    NSDate* endDate = [HelperMethods getDateFromString:[jsonDictionary objectForKey:@"EndDate"]];
    
    return [[EducationViewModel alloc]
            initWithId:[[jsonDictionary objectForKey:@"Id"] integerValue]
            andDegree:[[jsonDictionary objectForKey:@"Degree"] integerValue]
            andSpecialty:[jsonDictionary objectForKey:@"Specialty"]
            andOrganization:[jsonDictionary objectForKey:@"OrganizationName"]
            andDescription:[jsonDictionary objectForKey:@"Description"]
            andStartDate:startDate
            andEndDate:endDate
            andIndustry:[[jsonDictionary objectForKey:@"Industry"] integerValue]];
}

+(NSArray*) arrayOfEducationFromJsonDictionary: (NSArray*) jsonArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < jsonArray.count; i++) {
        [arr addObject:[EducationViewModel fromJsonDictionary:jsonArray[i]]];
    }
    
    return [NSArray arrayWithArray:arr];
}
@end
