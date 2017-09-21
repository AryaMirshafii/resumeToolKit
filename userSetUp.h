//
//  userSetUp.h
//  driveTest
//
//  Created by arya mirshafii on 9/12/17.
//  Copyright © 2017 Aryasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GoogleAPIClientForREST;
//#import <GoogleSignIn.h>
@interface userSetUp:NSObject
@property (nonatomic, strong) GTLRDriveService *driveService;
@property (nonatomic, strong) NSString *aFilePath;

@property(nonatomic, strong) NSString *folderIdentification;

-(id) initWithDriveService:(GTLRDriveService *)driveService withFilePath: (NSString *)aFilePath;
- (void ) initSetup;
//- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void ) uploadToFolder:(NSString *) folderId atFilePath: (NSString *)filePath;
- (void ) shareToDrive:(NSString *) fileId;
    //NSString *folderID;
    
@end
