//
//  ProjectViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "ProjectViewModel.h"

@implementation ProjectViewModel
-(instancetype) initWithId:(NSInteger) projectId
                  andTitle:(NSString*) title
            andDescription:(NSString*) description
                    andUrl:(NSString*) url{
    
    if (self = [super init]){
        self.projectId = projectId;
        self.title = title;
        self.projectDescription = description;
        self.url = url;
    }
    
    return self;
}

+(ProjectViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary{
    
    return [[ProjectViewModel alloc]
            initWithId:[[jsonDictionary objectForKey:@"Id"] integerValue]
            andTitle:[jsonDictionary objectForKey:@"Title"]
            andDescription:[jsonDictionary objectForKey:@"Description"]
            andUrl:[jsonDictionary objectForKey:@"Url"]];
}


+(NSArray*) arrayOfProjectsFromJsonDictionary: (NSArray*) jsonArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < jsonArray.count; i++) {
        [arr addObject:[ProjectViewModel fromJsonDictionary:jsonArray[i]]];
    }
    
    return [NSArray arrayWithArray:arr];
}
@end
