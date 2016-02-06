//
//  JobMatcherDatabase.h
//  JobMatcher.iOS
//
//  Created by s i on 2/6/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobMatcherDatabase : NSObject
+(JobMatcherDatabase*)database;
-(NSString*) getImagePathWithEmail: (NSString*) email;
-(void) addImagePath: (NSString*) imagePath withEmail:(NSString*) email;
@end
