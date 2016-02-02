//
//  ProjectViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectViewModel : NSObject

@property NSInteger projectId;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* projectDescription;
@property (strong, nonatomic) NSString* url;

-(instancetype) initWithId:(NSInteger) projectId
                  andTitle:(NSString*) title
               andDescription:(NSString*) description
                andUrl:(NSString*) url;

+(ProjectViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary;

+(NSArray*) arrayOfProjectsFromJsonDictionary: (NSArray*) jsonArray;
@end
