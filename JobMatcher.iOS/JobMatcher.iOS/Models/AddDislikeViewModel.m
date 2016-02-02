//
//  AddDislikeViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 2/1/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "AddDislikeViewModel.h"

@implementation AddDislikeViewModel

-(instancetype) initWithDisikedId:(NSString*)dislikedId
                 andMyAccountType:(NSString*)myAccountType{
    if (self = [super init]){
        self.dislikedId = dislikedId;
        self.myAccountType = myAccountType;
    }
    
    return self;
}

-(instancetype) initWithDisikedId:(NSString*)dislikedId
                 andMyAccountType:(NSString*)myAccountType
                    andJobOfferId:(NSString*)jobOfferId{
    if (self = [super init]){
        self.dislikedId = dislikedId;
        self.myAccountType = myAccountType;
        self.jobOfferId = jobOfferId;
    }
    
    return self;
}

+(AddDislikeViewModel*) dislikeWithDislikedId:(NSString*)dislikedId
                          andMyAccountType:(NSString*)myAccountType{
    return [[AddDislikeViewModel alloc] initWithDisikedId:dislikedId andMyAccountType:myAccountType];
}

+(AddDislikeViewModel*) dislikeWithDislikedId:(NSString*)dislikedId
                             andMyAccountType:(NSString*)myAccountType
                                andJobOfferId:(NSString*)jobOfferId{
    return [[AddDislikeViewModel alloc] initWithDisikedId:dislikedId andMyAccountType:myAccountType andJobOfferId:jobOfferId];
}

@end
