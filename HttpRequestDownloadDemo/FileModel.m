//
//  FileModel.m
//  learn
//
//  Created by User on 14-2-27.
//  Copyright (c) 2014年 kaikeba. All rights reserved.
//



#import "FileModel.h"


@implementation FileModel
@synthesize fileID;
@synthesize fileName;
@synthesize fileSize;
@synthesize fileType;
@synthesize isFirstReceived;
@synthesize fileReceivedData;
@synthesize fileReceivedSize;
@synthesize fileURL;
@synthesize targetPath;
@synthesize tempPath;
@synthesize isDownloading;
@synthesize willDownloading;
@synthesize error;
@synthesize time;
@synthesize isP2P;
@synthesize post;
@synthesize PostPointer,postUrl,fileUploadSize;
@synthesize MD5,usrname,fileimage;
@synthesize fileTitle,courseId;
-(id)init{
    self = [super init];
    
    return self;
}
-(void)dealloc{
    [fileTitle release];
    [courseId release];
    [fileID release];
    [fileName release];
    [fileSize release];
    [fileReceivedData release];
    [fileURL release];
    [time release];
    [targetPath release];
    [tempPath release];
    [fileType release];
    [postUrl release];
    [fileUploadSize release];
    [usrname release];
    [MD5 release];
    [fileimage release];
    [super dealloc];
}
@end

