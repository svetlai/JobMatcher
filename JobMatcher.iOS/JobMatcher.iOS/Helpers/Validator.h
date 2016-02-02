//
//  Validator.h
//  JobMatcher.iOS
//
//  Created by s i on 1/25/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Validator : UIViewController

-(BOOL) isValidLength: (int) length andParam:(NSString*)param;

-(BOOL) arePasswordsEqual: (NSString*)password andConfirmPassword: (NSString*) confirmPassword;

-(BOOL) isValidEmail: (NSString *) email;
@end
