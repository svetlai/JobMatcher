//
//  AddDislikeViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 2/1/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddDislikeViewModel : NSObject
@property NSString* dislikedId;
@property NSString* myAccountType;
@property NSString* jobOfferId;

-(instancetype) initWithDisikedId:(NSString*)dislikedId
                 andMyAccountType:(NSString*)myAccountType;

-(instancetype) initWithDisikedId:(NSString*)dislikedId
                 andMyAccountType:(NSString*)myAccountType
                    andJobOfferId:(NSString*)jobOfferId;

+(AddDislikeViewModel*) dislikeWithDislikedId:(NSString*)dislikedId
                             andMyAccountType:(NSString*)myAccountType;

+(AddDislikeViewModel*) dislikeWithDislikedId:(NSString*)dislikedId
                             andMyAccountType:(NSString*)myAccountType
                                andJobOfferId:(NSString*)jobOfferId;
@end
