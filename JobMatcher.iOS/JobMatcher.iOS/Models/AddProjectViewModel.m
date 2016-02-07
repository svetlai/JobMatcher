//
//  AddProjectViewModel.m
//  JobMatcher.iOS
//
//  Created by s i on 2/7/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "AddProjectViewModel.h"

@implementation AddProjectViewModel
-(instancetype) initWithTitle:(NSString*) title
               andDescription:(NSString*) projectDescription
                       andUrl:(NSString*) url;{
    
    if (self = [super init]){
        self.title = title;
        self.projectDescription = projectDescription;
        self.url = url;
    }
    
    return self;
}
+(AddProjectViewModel*) projectWithTitle:(NSString*) title
                           andDescription:(NSString*) projectDescription
                                   andUrl:(NSString*) url{
    
    return [[AddProjectViewModel alloc]
            initWithTitle:title
            andDescription:projectDescription
            andUrl:url];
}

@end
