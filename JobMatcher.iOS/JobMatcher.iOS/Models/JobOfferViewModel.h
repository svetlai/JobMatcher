//
//  JobOfferViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobOfferViewModel : NSObject

@property NSInteger jobOfferId;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* location;
@property (strong, nonatomic) NSString* jobOfferDescription;
@property NSInteger industry;
@property double salary;
@property NSInteger workHours;
@property NSInteger recruiterProfileId;
@property (strong, nonatomic) NSArray* interestedJobSeekers;

-(instancetype) initWithId:(NSInteger) jobOfferId
                  andTitle:(NSString*) title
               andLocation:(NSString*) location
            andDescription:(NSString*) jobOfferDescription
               andIndustry:(NSInteger) industry
                 andSalary:(double) salary
              andWorkHours:(NSInteger)workHours
     andRecruiterProfileId:(NSInteger)recruiterProfileId
    andInteresteJobSeekers:(NSArray*) interestedJobSeekers;

+(JobOfferViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary;

+(NSArray*) arrayOfJobOffersFromJsonDictionary: (NSArray*) jsonArray;

@end
