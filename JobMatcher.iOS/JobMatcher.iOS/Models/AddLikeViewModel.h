//
//  AddLikeViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 1/31/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddLikeViewModel : NSObject
@property NSString* likedId;
@property NSString* myAccountType;
@property NSString* jobOfferId;

-(instancetype) initWithLikedId:(NSString*)likedId
            andMyAccountType:(NSString*)myAccountType;

-(instancetype) initWithLikedId:(NSString*)likedId
               andMyAccountType:(NSString*)myAccountType
                  andJobOfferId:(NSString*)jobOfferId;

+(AddLikeViewModel*) likeWithLikedId:(NSString*)likedId
                 andMyAccountType:(NSString*)myAccountType;

+(AddLikeViewModel*) likeWithLikedId:(NSString*)likedId
                    andMyAccountType:(NSString*)myAccountType
                       andJobOfferId:(NSString*)jobOfferId;
@end
