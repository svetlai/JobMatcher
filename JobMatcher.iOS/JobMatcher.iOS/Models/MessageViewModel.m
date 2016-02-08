//
//  MessageViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "MessageViewModel.h"

@implementation MessageViewModel

-(instancetype) initWithId:(NSInteger) messageId
                andSubject:(NSString*) messageSubject
                andContent:(NSString*) messageContent
     andJobSeekerProfileId:(NSInteger) jobSeekerProfileId
     andRecruiterProfileId:(NSInteger) recruiterProfileId
               andSenderId:(NSInteger) senderId{
    
    if (self = [super init]){
        self.messageId = messageId;
        self.messageSubject = messageSubject;
        self.messageContent = messageContent;
        self.jobSeekerProfileId = jobSeekerProfileId;
        self.recruiterProfileId = recruiterProfileId;
        self.senderId = senderId;
    }
    
    return self;
}
+(MessageViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary{
    return [[MessageViewModel alloc]
            initWithId:[[jsonDictionary objectForKey:@"Id"] integerValue]
            andSubject:[jsonDictionary objectForKey:@"Subject"]
            andContent:[jsonDictionary objectForKey:@"Content"]
            andJobSeekerProfileId:[[jsonDictionary objectForKey:@"JobSeekerProfileId"] integerValue]
            andRecruiterProfileId:[[jsonDictionary objectForKey:@"RecruiterProfileId"] integerValue]
            andSenderId:[[jsonDictionary objectForKey:@"SenderId"] integerValue]];

}

+(NSArray*) arrayOfMessagesFromJsonDictionary: (NSArray*) jsonArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < jsonArray.count; i++) {
        [arr addObject:[MessageViewModel fromJsonDictionary:jsonArray[i]]];
    }
    
    return [NSArray arrayWithArray:arr];
}
@end
