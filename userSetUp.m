//
//  userSetUp.m
//  driveTest
//
//  Created by arya mirshafii on 9/12/17.
//  Copyright © 2017 Aryasoft. All rights reserved.
//


#import "userSetUp.h"
#import <GoogleSignIn/GoogleSignIn.h>
@import GoogleAPIClientForREST;


@implementation userSetUp
NSString *folderID;
-(id) initWithDriveService:(GTLRDriveService *)driveService{
    self = [ super init];
    if(self){
        self.driveService = driveService;
        
    }
    return self;
}
- (void) initSetup{
    
    
    
    GTLRDrive_File *metadata = [GTLRDrive_File object];
    metadata.name = @"Arya Mirshafii";
    metadata.mimeType = @"application/vnd.google-apps.folder";
    GTLRDriveQuery_FilesCreate *query = [GTLRDriveQuery_FilesCreate queryWithObject:metadata
                                                                   uploadParameters:nil];
    query.fields = @"id";
    [_driveService executeQuery:query completionHandler:^(GTLRServiceTicket *ticket,
                                                         GTLRDrive_File *file,
                                                         NSError *error) {
        if (error == nil) {
            folderID =  file.identifier;
            //[self shareToDrive:file.identifier];
            [self shareToDrive:file.identifier];
            //printf("the folder id is" + file.identifier )
            [self uploadToFolder: file.identifier];
            NSLog(@" FOLDER File ID %@", file.identifier);
        } else {
            NSLog(@"An error occurred: %@", error);
        }
    }];
    
    
    
    
    }
- (void) uploadToFolder:(NSString *) folderId {
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"apple" ofType:@"jpg"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    GTLRDrive_File *metadata = [GTLRDrive_File object];
    metadata.name = @"apple.jpg";
    
    //metadata.mimeType = @"application/vnd.google-apps.document";
    metadata.parents = [NSArray arrayWithObject:folderId];
    metadata.writersCanShare;
    //metadata.writersCanShare = true;
    //metadata.sha
    
    GTLRUploadParameters *uploadParameters = [GTLRUploadParameters uploadParametersWithData:fileData
                                                                                   MIMEType:@"image/jpeg"];
    uploadParameters.shouldUploadWithSingleRequest = TRUE;
    GTLRDriveQuery_FilesCreate *query = [GTLRDriveQuery_FilesCreate queryWithObject:metadata
                                                                   uploadParameters:uploadParameters];
    query.fields = @"id";
    [_driveService executeQuery:query completionHandler:^(GTLRServiceTicket *ticket,
                                                         GTLRDrive_File *file,
                                                         NSError *error) {
        if (error == nil) {
            /**
             *
             *This is where the file id of the file gets sent to be shared
             *
             */
            
           // [self shareToDrive:file.identifier];
            //
            NSLog(@"File ID %@", file.identifier);
        } else {
            NSLog(@"An error occurred: %@", error);
        }
    }];
    printf("uploaded image to folder");
}
- (void) shareToDrive:(NSString *) fileId {
    GTLRBatchQuery *batchQuery = [GTLRBatchQuery batchQuery];
    
    GTLRDrive_Permission *userPermission = [GTLRDrive_Permission object];
    userPermission.type = @"user";
    userPermission.role = @"writer";
    userPermission.emailAddress = @"gtexcelbackend@gmail.com";
    GTLRDriveQuery_PermissionsCreate *createUserPermission =
    [GTLRDriveQuery_PermissionsCreate queryWithObject:userPermission
                                               fileId:fileId];
    createUserPermission.fields = @"id";
    createUserPermission.completionBlock = ^(GTLRServiceTicket *ticket,
                                             GTLRDrive_Permission *permission,
                                             NSError *error) {
        if (error == nil) {
            NSLog(@"Permisson ID: %@", permission.identifier);
        } else {
            NSLog(@"An error occurred: %@", error);
        }
        
    };
    [batchQuery addQuery:createUserPermission];
    
    GTLRDrive_Permission *domainPermission = [GTLRDrive_Permission object];
    domainPermission.type = @"domain";
    domainPermission.role = @"reader";
    domainPermission.domain = @"gmail.com";
    
    GTLRDriveQuery_PermissionsCreate *createDomainPermission =
    [GTLRDriveQuery_PermissionsCreate queryWithObject:domainPermission
                                               fileId:fileId];
    createDomainPermission.fields = @"id";
    createDomainPermission.completionBlock = ^(GTLRServiceTicket *ticket,
                                               GTLRDrive_Permission *permission,
                                               NSError *error) {
        if (error == nil) {
            NSLog(@"Permisson ID: %@", permission.identifier);
        } else {
            NSLog(@"An error occurred: %@", error);
        }
    };
    [batchQuery addQuery:createDomainPermission];
    
    [_driveService executeQuery:batchQuery completionHandler:^(GTLRServiceTicket *ticket,
                                                              GTLRBatchResult *batchResult,
                                                              NSError *error) {
        if (error) {
            NSLog(@"An error occurred: %@", error);
        }
    }];
}
@end
