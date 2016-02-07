//
//  AddMessageViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 2/7/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "AddMessageViewModel.h"

@implementation AddMessageViewModel
-(instancetype) initWithSubject:(NSString*) messageSubject
                     andContent:(NSString*) messageContent
          andJobSeekerProfileId:(NSInteger) jobSeekerProfileId
          andRecruiterProfileId:(NSInteger) recruiterProfileId
                  andSenderAccountType:(NSString*) senderAccountType{
    
    if (self = [super init]){
        self.messageSubject = messageSubject;
        self.messageContent = messageContent;
        self.jobSeekerProfileId = jobSeekerProfileId;
        self.recruiterProfileId = recruiterProfileId;
        self.senderAccountType = senderAccountType;
    }
    
    return self;
}
+(AddMessageViewModel*) messageWithSubject:(NSString*) messageSubject
                                andContent:(NSString*) messageContent
                     andJobSeekerProfileId:(NSInteger) jobSeekerProfileId
                     andRecruiterProfileId:(NSInteger) recruiterProfileId
                      andSenderAccountType:(NSString*) senderAccountType;
{
    return [[AddMessageViewModel alloc]
            initWithSubject:(NSString*) messageSubject
            andContent:(NSString*) messageContent
            andJobSeekerProfileId:(NSInteger) jobSeekerProfileId
            andRecruiterProfileId:(NSInteger) recruiterProfileId
            andSenderAccountType:(NSString*) senderAccountType];
}
@end
