//
//  EditJobSeekerProfileViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 2/8/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditJobSeekerProfileViewModel : NSObject
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* phoneNumber;
@property (strong, nonatomic) NSString* currentPosition;
@property (strong, nonatomic) NSString* summary;
@property NSInteger profileId;

-(instancetype) initWithFirstName:(NSString*) firstName
                    andLastName:(NSString*) lastName
                      andPhoneNumber:(NSString*) phoneNumber
               andCurrentPosition:(NSString*) currentPosition
                       andSummary:(NSString*) summary
                     andProfileId: (NSInteger) profileId;

+(EditJobSeekerProfileViewModel*) profileWithFirstName:(NSString*) firstName
                            andLastName:(NSString*) lastName
                         andPhoneNumber:(NSString*) phoneNumber
                     andCurrentPosition:(NSString*) currentPosition
                             andSummary:(NSString*) summary
                            andProfileId: (NSInteger) profileId;

+(EditJobSeekerProfileViewModel*) fromJsonDictionary:(NSDictionary *)jsonDictionary;
+(NSArray*) arrayOfJobSeekersFromJsonDictionary: (NSArray*) jsonArray;
@end
