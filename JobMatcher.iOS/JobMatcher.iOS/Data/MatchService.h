//
//  MatchService.h
//  JobMatcher.iOS
//
//  Created by s i on 1/31/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddLikeViewModel.h"
#import "AddDislikeViewModel.h"

@interface MatchService : NSObject
-(void) addLikeWithModel:(AddLikeViewModel*)model andTarget:(NSObject*) target;
-(void) addDislikeWithModel:(AddDislikeViewModel*)model andTarget:(NSObject*) target;
@end
