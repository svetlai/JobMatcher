//
//  AddSkillViewModel.h
//  JobMatcher.iOS
//
//  Created by s i on 2/8/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddSkillViewModel : NSObject
@property (strong, nonatomic) NSString* name;
@property NSInteger level;

-(instancetype) initWithName:(NSString*) name
                     andLevel:(NSInteger) level;

+(AddSkillViewModel*) skillWithName:(NSString*) name
                          andLevel:(NSInteger) level;
@end
