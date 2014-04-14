//
//  ViewController.h
//  HttpRequestDownloadDemo
//
//  Created by MagicLGD on 14-3-24.
//  Copyright (c) 2014年 123. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadDelegate.h"
#import "ASIHTTPRequest.h"
@interface ViewController : UIViewController<ASIHTTPRequestDelegate,DownloadDelegate,UICollectionViewDataSource,UICollectionViewDelegate>


@property (strong, nonatomic) IBOutlet UICollectionView * collectView;
@property(nonatomic,strong)NSMutableArray *downingList;
@end
