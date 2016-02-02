//
//  EducationViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EducationViewModel : NSObject

@property NSInteger educationId;
@property NSInteger degree;
@property (strong, nonatomic) NSString* organization;
@property (strong, nonatomic) NSString* specialty;
@property (strong, nonatomic) NSString* educationDescription;
@property (strong, nonatomic) NSDate* startDate;
@property (strong, nonatomic) NSDate* endDate;
@property NSInteger industry;

-(instancetype) initWithId:(NSInteger) educationId
                 andDegree:(NSInteger) degree
              andSpecialty:(NSString*) specialty
           andOrganization:(NSString*) organization
            andDescription:(NSString*) educationDescription
              andStartDate:(NSDate*) startDate
                andEndDate:(NSDate*) endDate
               andIndustry:(NSInteger) industry;

+(EducationViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary;

+(NSArray*) arrayOfEducationFromJsonDictionary: (NSArray*) jsonArray;
@end
