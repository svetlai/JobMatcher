//
//  MessageViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "MessageViewModel.h"

@implementation MessageViewModel

+(MessageViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary{
    return [[MessageViewModel alloc] init];
}

+(NSArray*) arrayOfMessagesFromJsonDictionary: (NSArray*) jsonArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < jsonArray.count; i++) {
        [arr addObject:[MessageViewModel fromJsonDictionary:jsonArray[i]]];
    }
    
    return [NSArray arrayWithArray:arr];
}
@end
