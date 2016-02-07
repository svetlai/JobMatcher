//
//  HelperMethods.m
//  JobMatcher.iOS
//
//  Created by s i on 1/25/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#import "HelperMethods.h"
#import "JobMatcher_iOS-Swift.h"

@implementation HelperMethods

+(void) addAlert: (NSString*) message{
    SweetAlert* sweetAlert = [[SweetAlert alloc] init];
    [sweetAlert showAlert:message];
    
//            [[[UIAlertView alloc] initWithTitle:nil message: message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]
//             show];
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

+(UILabel *)resizeLabel:(UILabel*)label andText: (NSString*)text andTarget: (UIView*)view{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    //    CGFloat screenHeight = screenRect.size.height;
    
//    NSLog(@"%f",label.frame.size.width);
//    NSLog(@"%f",view.frame.size.width);
//    NSLog(@"%l",label.textAlignment);
    
    //TODO: width and text alignment
    [label setText: @""];
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width - 100, label.frame.size.height)];
    [newLabel setTextColor: label.textColor];
    [newLabel setBackgroundColor: [UIColor clearColor]];
    [newLabel setFont: label.font];
    [newLabel setText: text];
    [newLabel setNumberOfLines:0];
    [newLabel sizeToFit];
    [newLabel setTextAlignment:label.textAlignment];

    [view addSubview:newLabel];
    return newLabel;
}

@end
