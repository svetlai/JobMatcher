//
//  JobMatcherDatabase.m
//  JobMatcher.iOS
//
//  Created by s i on 2/6/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "JobMatcherDatabase.h"
//#import <sqlite3.h>
#import "FMDatabase.h"
#import "GlobalConstants.h"

@implementation JobMatcherDatabase {
    //sqlite3* _db;
    NSArray  *paths;
    NSString *docsPath;
    NSString *dbPath;
    FMDatabase *database;
}

-(instancetype)init{
    if (self = [super init]){
        paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsPath = [paths objectAtIndex:0];
        dbPath = [docsPath stringByAppendingPathComponent:JobMatcherDb];
        
        database = [FMDatabase databaseWithPath:dbPath];
        [self createTable];
//        NSString* sqLiteDb = [[NSBundle mainBundle] pathForResource:JobMatcherDb ofType:@"db"];
//        if (sqlite3_open([sqLiteDb UTF8String], &_db)){
//            NSLog(@"Db error");
//        }
    }
    
    return self;
}

-(void) dealloc{
//    if (_db != nil){
//        sqlite3_close(_db);
//    }
    
    if (database != nil){
       [database close];
    }
}

+(JobMatcherDatabase*)database{
    static JobMatcherDatabase* databaseInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         databaseInstance = [[JobMatcherDatabase alloc] init];
    });
    
    return databaseInstance;
}

-(void) createTable{
    [database open];
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS Profile (Image TEXT,Email TEXT)"];
    [database close];
}

-(NSString*) getImagePathWithEmail: (NSString*) email {
    [database open];
    NSString *sqlSelectQuery = @"SELECT * FROM Profile";
    
    // Query result
    FMResultSet *resultsWithNameLocation = [database executeQuery:sqlSelectQuery];
    while([resultsWithNameLocation next]) {
        NSString *strImage = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"Image"]];
        NSString *strEmail = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"Email"]];
        //NSLog(@"Image = %@, Email = %@", strImage, strEmail);

        if ([strEmail isEqualToString:email]){
            [database close];
            return strImage;
        }
    }
    
    [database close];
    return nil;
}

-(void) addImagePath: (NSString*) imagePath withEmail:(NSString*) email {
    NSString* query;
    NSString* existingPath = [self getImagePathWithEmail: email];
     [database open];
    if (existingPath == nil){
       query = [NSString stringWithFormat:@"INSERT INTO Profile VALUES ('%@', '%@')", imagePath, email];
    }else{
        query = [NSString stringWithFormat:@"UPDATE Profile SET Image = '%@' WHERE Email = '%@'", imagePath, email];
    }
    
    [database executeUpdate:query];
    [database close];
}

// NSString* query = @"DELETE FROM Profile WHERE Email = 'meme@me.me'"
// NSString* query = [NSString stringWithFormat:@"INSERT INTO Profile VALUES ('%@', '%@')", imagePath, email]
// NSString* query = [NSString stringWithFormat:@"UPDATE Profile SET Image = '%@' WHERE Email = '%@", imagePath, email];
- (void)executeWithQuery: (NSString*) query {
    [database open];
    NSString *deleteQuery = query;
    [database executeUpdate:deleteQuery];
    [database close];
}

//-(NSString*) getImagePathWithEmail: (NSString*) email{
//    NSString* query = [NSString stringWithFormat:@"SELECT Image, Email FROM Profile"];
//    sqlite3_stmt* statement;
//    if (sqlite3_prepare(_db, [query UTF8String], -1, &statement, nil) == SQLITE_OK){
//        while(sqlite3_step(statement) == SQLITE_ROW){
//
//            char* emailChars =  (char *) sqlite3_column_text(statement, 1);
//            NSString* dbEmail = [NSString stringWithUTF8String:emailChars];
//
//            if ([dbEmail isEqualToString:email]){
//                 char *imageChars = (char *) sqlite3_column_text(statement, 0);
//                NSString* imagePath = [NSString stringWithUTF8String:imageChars];
//                [self createTable];
//                [self insertData];
//                              [self getAllData ];
//                return imagePath;
//            }
//        }
//    }
//
//
//    return nil;
//}

@end
