//
//  SkillViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkillViewModel : NSObject

@property NSInteger skillId;
@property (strong, nonatomic) NSString* name;
@property NSInteger level;

-(instancetype) initWithId:(NSInteger) skillId
                   andName:(NSString*) name
                  andLevel:(NSInteger) level;

+(SkillViewModel*) fromJsonDictionary: (NSDictionary*) jsonDictionary;

+(NSArray*) arrayOfSkillsFromJsonDictionary: (NSArray*) jsonArray;
@end
