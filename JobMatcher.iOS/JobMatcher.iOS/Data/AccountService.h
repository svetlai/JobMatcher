//
//  AccountService.h
//  JobMatcher.iOS
//
//  Created by s i on 1/25/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountService : NSObject
//@property (strong, nonatomic) NSString* authorizationToken;
//@property (strong, nonatomic) NSString* loggedUserName;

-(void) registerUserWithEmail: (NSString*) email andPassword: (NSString*) password andProfileType: (NSString*) profileType andTarget: (NSObject*) target;

-(void) loginUserWithEmail: (NSString*) email andPassword: (NSString*) password andTarget:(NSObject*) target;
@end
