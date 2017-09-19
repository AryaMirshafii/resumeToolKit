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
-(id) initWithDriveService:(GTLRDriveService *)driveService;
- (void ) initSetup;
- (void ) uploadToFolder:(NSString *) folderId;
- (void ) shareToDrive:(NSString *) fileId;
    //NSString *folderID;
    
@end
