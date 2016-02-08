//
//  JobOfferService.h
//  JobMatcher.iOS
//
//  Created by s i on 2/2/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddJobOfferViewModel.h"

@interface JobOfferService : NSObject
-(void) getRandomOfferWithTarget:(NSObject*) target;
-(void) addOfferWithModel:(AddJobOfferViewModel*)model andTarget:(NSObject*) target;
-(void) deleteOfferWithId: (NSInteger) id andTarget:(NSObject*) target;
@end
