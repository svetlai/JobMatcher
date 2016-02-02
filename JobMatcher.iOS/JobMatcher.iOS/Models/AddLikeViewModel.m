//
//  AddLikeViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 1/31/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "AddLikeViewModel.h"

@implementation AddLikeViewModel
-(instancetype) initWithLikedId:(NSString*)likedId
            andMyAccountType:(NSString*)myAccountType{
    if (self = [super init]){
        self.likedId = likedId;
        self.myAccountType = myAccountType;
    }
    return self;
}

-(instancetype) initWithLikedId:(NSString*)likedId
               andMyAccountType:(NSString*)myAccountType
                  andJobOfferId:(NSString*)jobOfferId{
    if (self = [super init]){
        self.likedId = likedId;
        self.myAccountType = myAccountType;
        self.jobOfferId = jobOfferId;
    }
    
    return self;
}

+(AddLikeViewModel*) likeWithLikedId:(NSString*)likedId
                 andMyAccountType:(NSString*)myAccountType{
   return [[AddLikeViewModel alloc] initWithLikedId:likedId andMyAccountType:myAccountType];
}

+(AddLikeViewModel*) likeWithLikedId:(NSString*)likedId
                    andMyAccountType:(NSString*)myAccountType
                       andJobOfferId:(NSString*)jobOfferId{
    return [[AddLikeViewModel alloc] initWithLikedId:likedId
                                    andMyAccountType:myAccountType
                                       andJobOfferId:jobOfferId];
}
@end
