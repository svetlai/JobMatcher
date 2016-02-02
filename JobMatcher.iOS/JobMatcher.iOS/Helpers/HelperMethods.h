//
//  HelperMethods.h
//  JobMatcher.iOS
//
//  Created by s i on 1/25/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelperMethods :  UIViewController
+(void) addAlert: (NSString*) message;
+(void) setPageTitle: (UIViewController*) page andTitle: (NSString*) title;
+(void) setSackBarButtonText: (UIViewController*) page andText: (NSString*) text;
+(NSDate*)getDateFromString: (NSString*) dateAsString;
+(NSString*)getShortDateString: (NSDate*) date;
@end
