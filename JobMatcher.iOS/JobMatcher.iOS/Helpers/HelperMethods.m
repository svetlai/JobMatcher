//
//  HelperMethods.m
//  JobMatcher.iOS
//
//  Created by s i on 1/25/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "HelperMethods.h"

@implementation HelperMethods
+(void) addAlert: (NSString*) message{
            [[[UIAlertView alloc] initWithTitle:nil message: message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]
             show];
}

+(void) setPageTitle: (UIViewController*) page andTitle: (NSString*) title{
    page.navigationItem.title = title;
    
    }

+(void) setSackBarButtonText: (UIViewController*) page andText: (NSString*) text{
    page.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:text
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];

}

// http://stackoverflow.com/questions/12033892/converting-date-of-format-yyyy-mm-ddthhmmss-sss
+(NSDate*)getDateFromString: (NSString*) dateAsString{
    NSDateFormatter *isoFormat = [[NSDateFormatter alloc] init];
    [isoFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *date = [isoFormat dateFromString:dateAsString];
    
    return date;
}

+(NSString*)getShortDateString: (NSDate*) date{
    NSDateFormatter *shortFormat = [[NSDateFormatter alloc] init];
    [shortFormat setDateFormat:@"MMM dd, yyyy"];
    
    return[shortFormat stringFromDate:date];
}

@end
