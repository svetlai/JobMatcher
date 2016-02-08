//
//  MessageViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageViewModel : NSObject
@property NSInteger messageId;
@property (strong, nonatomic) NSString* messageSubject;
@property (strong, nonatomic) NSString* messageContent;
@property NSInteger jobSeekerProfileId;
@property NSInteger recruiterProfileId;
@property NSInteger senderId;

-(instancetype) initWithId:(NSInteger) messageId
                andSubject:(NSString*) messageSubject
                andContent:(NSString*) messageContent
     andJobSeekerProfileId:(NSInteger) jobSeekerProfileId
     andRecruiterProfileId:(NSInteger) recruiterProfileId
               andSenderId:(NSInteger) senderId;
//TODO
+(MessageViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary;

+(NSArray*) arrayOfMessagesFromJsonDictionary: (NSArray*) jsonArray;
@end
