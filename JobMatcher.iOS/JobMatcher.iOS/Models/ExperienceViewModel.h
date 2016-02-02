//
//  ExperienceViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExperienceViewModel : NSObject

@property NSInteger experienceId;
@property (strong, nonatomic) NSString* position;
@property (strong, nonatomic) NSString* organization;
@property (strong, nonatomic) NSString* experienceDescription;
@property (strong, nonatomic) NSDate* startDate;
@property (strong, nonatomic) NSDate* endDate;
@property NSInteger industry;

-(instancetype) initWithId:(NSInteger) experienceId
               andPosition:(NSString*) position
           andOrganization:(NSString*) organization
            andDescription:(NSString*) experienceDescription
              andStartDate:(NSDate*) startDate
                andEndDate:(NSDate*) endDate
               andIndustry:(NSInteger) industry;

+(ExperienceViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary;

+(NSArray*) arrayOfExperienceFromJsonDictionary: (NSArray*) jsonArray;
@end
