//
//  EditJobSeekerProfileViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 2/8/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "EditJobSeekerProfileViewModel.h"

@implementation EditJobSeekerProfileViewModel
-(instancetype) initWithFirstName:(NSString*) firstName
                      andLastName:(NSString*) lastName
                   andPhoneNumber:(NSString*) phoneNumber
               andCurrentPosition:(NSString*) currentPosition
                       andSummary:(NSString*) summary
  andProfileId: (NSInteger) profileId{
    
    if (self = [super init]){
        self.firstName = firstName;
        self.lastName = lastName;
        self.phoneNumber = phoneNumber;
        self.currentPosition = currentPosition;
        self.summary = summary;
        self.profileId = profileId;
    }
    
    return self;
}

+(EditJobSeekerProfileViewModel*) profileWithFirstName:(NSString*) firstName
                                           andLastName:(NSString*) lastName
                                        andPhoneNumber:(NSString*) phoneNumber
                                    andCurrentPosition:(NSString*) currentPosition
                                            andSummary:(NSString*) summary
  andProfileId: (NSInteger) profileId{
    
    return [[EditJobSeekerProfileViewModel alloc] initWithFirstName:firstName
                                                        andLastName:lastName
                                                     andPhoneNumber: phoneNumber
                                                 andCurrentPosition: currentPosition
                                                         andSummary: summary
              andProfileId:profileId];
}

+(EditJobSeekerProfileViewModel*) fromJsonDictionary:(NSDictionary *)jsonDictionary{
    return [[EditJobSeekerProfileViewModel alloc]
            initWithFirstName:[jsonDictionary objectForKey:@"FirstName"]
            andLastName:[jsonDictionary objectForKey:@"LastName"]
            andPhoneNumber:[jsonDictionary objectForKey:@"PhoneNumber"]
              andCurrentPosition:[jsonDictionary objectForKey:@"CurrentPosition"]
            andSummary:[jsonDictionary objectForKey:@"Summary"]
            andProfileId:[[jsonDictionary objectForKey:@"JobSeekerProfileId"] integerValue]];
}


+(NSArray*) arrayOfJobSeekersFromJsonDictionary: (NSArray*) jsonArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < jsonArray.count; i++) {
        [arr addObject:[EditJobSeekerProfileViewModel fromJsonDictionary:jsonArray[i]]];
    }
    
    return [NSArray arrayWithArray:arr];
}
@end
