//
//  DownloadCell.m
//  learn
//
//  Created by User on 14-3-8.
//  Copyright (c) 2014年 kaikeba. All rights reserved.
//

#import "DownloadCell.h"
#import "CommonHelper.h"

@interface DownloadCell(){
    FileModel *_model;
}

@end

@implementation DownloadCell



- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"DownloadCell" owner:self options: nil];
        if(arrayOfViews.count < 1){return nil;}
        if(![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]){
            return nil;
        }
        self = [arrayOfViews objectAtIndex:0];
        
        [_videoImv setClipsToBounds:YES];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateProgress:)
                                                     name:@"CellDownloadProgress"
                                                   object:nil];
        [_playButton addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton addTarget:self action:@selector(deletePressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
//CellDownloadProgress
- (void)configureWithFileModel:(FileModel*)model{
    _model = model;
    _vidoTitle.text = _model.fileTitle;
    if(_model.fileSize < _model.fileReceivedSize){
    _videoSizeLabel.text = [NSString stringWithFormat:@"%@/%@",[CommonHelper getFileSizeString:_model.fileReceivedSize],[CommonHelper getFileSizeString:_model.fileSize]];
    }else{
        _videoSizeLabel.text = [NSString stringWithFormat:@"%@",[CommonHelper getFileSizeString:_model.fileReceivedSize]];

    }
    [_playButton setSelected:!_model.isDownloading];
    [_videoStateLabel setText:_model.isDownloading?@"下载中":(_model.fileSize > _model.fileReceivedSize?@"暂停":@"下载完成")];
    [_pView setHidden:_model.fileSize <= _model.fileReceivedSize];
    if (_model.fileSize > _model.fileReceivedSize) {
        [_pView setProgress:[_model.fileReceivedSize integerValue]*1.0/[_model.fileSize integerValue]];
    }
}

- (IBAction)download:(id)sender {
    [_playButton setSelected:![_playButton isSelected]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PauseDownload"
                                                        object:nil
                                                      userInfo:@{@"fileModel":_model,
                                                                 @"pause": @(_playButton.selected)}];
}

- (IBAction)deletePressed:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"是否删除该视频？"] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" , nil];
    [alert show];
    
    
}
-(void)alertView:(UIAlertView *) alertView clickedButtonAtIndex:(NSInteger) buttonIndex
{
 
        switch(buttonIndex){
            case 0:
            {
                if (_actionTarget != nil && [_actionTarget respondsToSelector:@selector(deleteDownload:)]) {
                    [_actionTarget performSelector:@selector(deleteDownload:) withObject:_model];
                }
            }
                break;
            case 1:
            {
                
            }
                break;
                
        }
    
    
    
}


- (void)updateProgress:(NSNotification*)notification{
    ASIHTTPRequest *request = [notification.userInfo objectForKey:@"request"];
    FileModel *fileInfo = [request.userInfo objectForKey:@"File"];
    if (![fileInfo.fileURL isEqualToString:_model.fileURL]) {
        return;
    }
    
    _videoSizeLabel.text = [NSString stringWithFormat:@"%@/%@",[CommonHelper getFileSizeString:_model.fileReceivedSize],[CommonHelper getFileSizeString:_model.fileSize]];
    
    float progress = [[fileInfo fileReceivedSize] longLongValue] * 1.0 / [_model.fileSize longLongValue];
    [_pView setProgress:progress];
    [_pView setHidden:progress >= 1];
    [_playButton setHidden:progress >= 1];
    if (progress >= 1) {
        [_videoStateLabel setText:@"下载完成"];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"CellDownloadProgress"
                                                  object:nil];
}

@end
