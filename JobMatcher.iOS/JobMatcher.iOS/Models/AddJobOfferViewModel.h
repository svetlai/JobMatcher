//
//  AddJobOfferViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 2/7/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddJobOfferViewModel : NSObject
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* jobOfferDescription;
@property long indusry;
@property long workHours;
@property (strong, nonatomic) NSString* salary;
@property NSInteger recruiterProfileId;
@property double latitude;
@property double longitude;

-(instancetype) initWithTitle:(NSString*) title
                andDescription:(NSString*) jobOfferDescription
                andIndusry:(long) indusry
                andWorkHours:(long) workHours
                andSalary:(NSString*) salary
        andRecruiterProfileId:(NSInteger) recruiterProfileId
                  andLatitude:(double) latitude
                 andLongitude:(double) longitude;

+(AddJobOfferViewModel*) offerWithTitle:(NSString*) title
                        andDescription:(NSString*) jobOfferDescription
                            andIndusry:(long) indusry
                          andWorkHours:(long) workHours
                             andSalary:(NSString*) salary
                 andRecruiterProfileId:(NSInteger) recruiterProfileId
                            andLatitude:(double) latitude
                           andLongitude:(double) longitude;
@end

