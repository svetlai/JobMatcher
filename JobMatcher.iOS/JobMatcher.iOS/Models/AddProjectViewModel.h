//
//  AddProjectViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 2/7/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddProjectViewModel : NSObject
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* projectDescription;
@property (strong, nonatomic) NSString* url;

-(instancetype) initWithTitle:(NSString*) title
               andDescription:(NSString*) projectDescription
                       andUrl:(NSString*) url;

+(AddProjectViewModel*) projectWithTitle:(NSString*) title
                         andDescription:(NSString*) projectDescription
                                  andUrl:(NSString*) url;

@end
