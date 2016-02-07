//
//  AddJobOfferViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 2/7/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "AddJobOfferViewModel.h"

@implementation AddJobOfferViewModel
-(instancetype) initWithTitle:(NSString*) title
               andDescription:(NSString*) jobOfferDescription
                   andIndusry:(long) indusry
                 andWorkHours:(long) workHours
                    andSalary:(NSString*) salary
        andRecruiterProfileId:(NSInteger) recruiterProfileId
                  andLatitude:(double) latitude
                 andLongitude:(double) longitude{
    
    if (self = [super init]){
        self.title = title;
        self.jobOfferDescription = jobOfferDescription;
        self.indusry = indusry;
        self.workHours = workHours;
        self.salary = salary;
        self.recruiterProfileId = recruiterProfileId;
        self.latitude = latitude;
        self.longitude = longitude;
    }
    
    return self;
}

+(AddJobOfferViewModel*) offerWithTitle:(NSString*) title
                        andDescription:(NSString*) jobOfferDescription
                            andIndusry:(long) indusry
                          andWorkHours:(long) workHours
                             andSalary:(NSString*) salary
                 andRecruiterProfileId:(NSInteger) recruiterProfileId
                            andLatitude:(double) latitude
                           andLongitude:(double) longitude;
{
    return [[AddJobOfferViewModel alloc]
            initWithTitle:(NSString*) title
            andDescription:(NSString*) jobOfferDescription
            andIndusry:(long) indusry
            andWorkHours:(long) workHours
            andSalary:(NSString*) salary
            andRecruiterProfileId:(NSInteger) recruiterProfileId
            andLatitude:(double) latitude
            andLongitude:(double) longitude];
}

@end


