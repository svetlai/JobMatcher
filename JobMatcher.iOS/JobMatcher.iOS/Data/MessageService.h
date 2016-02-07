//
//  MessageService.h
//  JobMatcher.iOS
//
//  Created by s i on 2/7/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddMessageViewModel.h"

@interface MessageService : NSObject
-(void) addMessageWithModel:(AddMessageViewModel*)model andTarget:(NSObject*) target;
@end
