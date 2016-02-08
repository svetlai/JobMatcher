//
//  AddMessageViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 2/7/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddMessageViewModel : NSObject
@property (strong, nonatomic) NSString* messageSubject;
@property (strong, nonatomic) NSString* messageContent;
@property NSInteger jobSeekerProfileId;
@property NSInteger recruiterProfileId;
@property (strong, nonatomic) NSString*  senderAccountType;

-(instancetype) initWithSubject:(NSString*) messageSubject
                andContent:(NSString*) messageContent
     andJobSeekerProfileId:(NSInteger) jobSeekerProfileId
     andRecruiterProfileId:(NSInteger) recruiterProfileId
               andSenderAccountType:(NSString*) senderAccountType;

+(AddMessageViewModel*) messageWithSubject:(NSString*) messageSubject
                             andContent:(NSString*) messageContent
                  andJobSeekerProfileId:(NSInteger) jobSeekerProfileId
                  andRecruiterProfileId:(NSInteger) recruiterProfileId
                            andSenderAccountType:(NSString*) senderAccountType;

@end
