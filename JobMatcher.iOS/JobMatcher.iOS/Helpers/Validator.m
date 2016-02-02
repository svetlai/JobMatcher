//
//  Validator.m
//  JobMatcher.iOS
//
//  Created by s i on 1/25/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "Validator.h"

@implementation Validator

-(BOOL) isValidLength: (int) length andParam:(NSString*)param{
    if (param.length >= length){        
        return true;
    }
    
    return false;
}

-(BOOL) arePasswordsEqual: (NSString*)password andConfirmPassword: (NSString*) confirmPassword{
    if ([password isEqualToString:confirmPassword]){
        return true;
    }
    
    return false;
}

- (BOOL) isValidEmail: (NSString *) email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}
@end
