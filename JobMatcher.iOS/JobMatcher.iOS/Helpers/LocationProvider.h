//
//  LocationProvider.h
//  JobMatcher.iOS
//
//  Created by s i on 2/7/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationProvider : NSObject
-(void) getLocationWithBlock: (void(^)(CLLocation* location)) block;

-(void) getLocationWithTarget:(id) target
                    andAction:(SEL) action;
@end
