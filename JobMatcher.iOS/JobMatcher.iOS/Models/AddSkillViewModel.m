//
//  AddSkillViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 2/8/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "AddSkillViewModel.h"

@implementation AddSkillViewModel
-(instancetype) initWithName:(NSString*) name
                    andLevel:(NSInteger) level{
    
    if (self = [super init]){
        self.name = name;
        self.level = level;
    }
    
    return self;
}
+(AddSkillViewModel*) skillWithName:(NSString*) name
                          andLevel:(NSInteger) level{
    
    return [[AddSkillViewModel alloc]
            initWithName:name
            andLevel:level];
}

@end
