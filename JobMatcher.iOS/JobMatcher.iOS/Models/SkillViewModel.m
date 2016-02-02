//
//  SkillViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "SkillViewModel.h"

@implementation SkillViewModel
-(instancetype) initWithId:(NSInteger) skillId
                   andName:(NSString*) name
                  andLevel:(NSInteger) level{
    if (self = [super init]){
        self.skillId = skillId;
        self.name = name;
        self.level = level;
    }
    
    return self;
}

+(SkillViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary{
    return [[SkillViewModel alloc]
            initWithId:[[jsonDictionary objectForKey:@"Id"] integerValue]
            andName:[jsonDictionary objectForKey:@"Name"]
            andLevel:[[jsonDictionary objectForKey:@"Level"] integerValue]];
}

+(NSArray*) arrayOfSkillsFromJsonDictionary: (NSArray*) jsonArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < jsonArray.count; i++) {
        [arr addObject:[SkillViewModel fromJsonDictionary:jsonArray[i]]];
    }
    
    return [NSArray arrayWithArray:arr];
}
@end
