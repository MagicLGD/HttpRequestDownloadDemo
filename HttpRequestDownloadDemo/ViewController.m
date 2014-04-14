//
//  ViewController.m
//  HttpRequestDownloadDemo
//
//  Created by MagicLGD on 14-3-24.
//  Copyright (c) 2014年 123. All rights reserved.
//

#import "ViewController.h"
#import "DownloadCell.h"
#import "FilesDownManage.h"
@interface ViewController ()

@end

@implementation ViewController
NSString *const KCellID = @"CollectionCell";
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UINib *nib = [UINib nibWithNibName:@"DownloadCell" bundle:nil];
    [self.collectView registerNib:nib
                  forCellWithReuseIdentifier:KCellID];
    [self.collectView registerClass:[DownloadCell class]
                    forCellWithReuseIdentifier:KCellID];
    
     _downingList = [NSMutableArray array];
}
-(void)viewWillAppear:(BOOL)animated
{
    [_downingList removeAllObjects];
    
    [FilesDownManage sharedFilesDownManageWithBasepath:@"DownLoad" TargetPathArr:[NSArray arrayWithObject:@"DownLoad/mp4"]];
    [FilesDownManage sharedFilesDownManage].downloadDelegate = self;
    FilesDownManage *filedownmanage = [FilesDownManage sharedFilesDownManage];
    
    //    [filedownmanage startLoad];
    
    /*
     NSDictionary *filedic = [NSDictionary dictionaryWithObjectsAndKeys:
     fileinfo.fileName,@"filename",
     fileinfo.fileURL,@"fileurl",
     fileinfo.fileTitle,@"time",
     _basepath,@"basepath",
     _TargetSubPath,@"tarpath" ,
     fileinfo.fileSize,@"filesize",
     fileinfo.fileReceivedSize,@"filerecievesize",
     fileinfo.courseId,@"courseID",
     nil];
     */
    
    @synchronized(filedownmanage.downinglist){
        for (ASIHTTPRequest *theRequest in filedownmanage.downinglist) {
            if (theRequest!=nil) {
                [_downingList addObject:theRequest];
            }
        }
    }
    
    @synchronized(filedownmanage.finishedlist){
        for (FileModel *fileInfo in filedownmanage.finishedlist) {
            [_downingList addObject:fileInfo];
        }
    }
    
    [self.collectView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _downingList.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
        return 1;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        DownloadCell *cell = (DownloadCell *)[collectionView dequeueReusableCellWithReuseIdentifier:KCellID forIndexPath:indexPath];
        [cell setActionTarget:self];
        
    
        
        if([[_downingList objectAtIndex:indexPath.row] isKindOfClass:[FileModel class]] == YES){
            
            FileModel *fileInfo = [_downingList objectAtIndex:indexPath.row];
            [cell configureWithFileModel:fileInfo];
            
            cell.videoStateLabel.hidden = YES;
            cell.playButton.hidden = [fileInfo.fileReceivedSize integerValue] >= [fileInfo.fileSize integerValue];
            cell.pView.hidden = YES;
            
        } else if([[_downingList objectAtIndex:indexPath.row] isKindOfClass:[ASIHTTPRequest class]] == YES) {
            ASIHTTPRequest *theRequest = [_downingList objectAtIndex:indexPath.row];
            if (theRequest == nil) {
                return nil;
            }
            FileModel *fileInfo = [theRequest.userInfo objectForKey:@"File"];
            [cell configureWithFileModel:fileInfo];
            
            cell.videoStateLabel.text = @"下载中";
            cell.playButton.selected = !theRequest.isExecuting;
          
        }
        return cell;
}
- (void)deleteDownload:(FileModel*)model{
    __block ASIHTTPRequest *request = nil;
    [_downingList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[ASIHTTPRequest class]] &&
            [[(FileModel*)[[obj userInfo] objectForKey:@"File"] fileName] isEqualToString:model.fileName]) {
            request = obj;
            [request cancel];
                [[FilesDownManage sharedFilesDownManage] deleteRequest:request];
               
            } else if ([[(FileModel*)obj fileName] isEqualToString:model.fileName]){
                request = obj;
                [[FilesDownManage sharedFilesDownManage] deleteFileModel:(FileModel*)request];
               
            }
        
        if (request != nil) {
            [_downingList removeObject:obj];
            *stop = YES;
        }
    }];
    
    FilesDownManage *filedownmanage = [FilesDownManage sharedFilesDownManage];

    @synchronized(filedownmanage.downinglist){
        for (ASIHTTPRequest *theRequest in filedownmanage.downinglist) {
            if (theRequest!=nil) {
                [_downingList addObject:theRequest];
            }
        }
    }
    
    @synchronized(filedownmanage.finishedlist){
        for (FileModel *fileInfo in filedownmanage.finishedlist) {
            [_downingList addObject:fileInfo];
        }
    }
    

    [_collectView reloadData];
}

@end
