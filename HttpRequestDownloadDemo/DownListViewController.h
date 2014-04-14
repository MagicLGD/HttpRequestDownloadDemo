//
//  DownListViewController.h
//  HttpRequestDownloadDemo
//
//  Created by MagicLGD on 14-3-24.
//  Copyright (c) 2014年 123. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* downContentDatas;
    NSArray* downURLArr;
}
@property (strong, nonatomic) IBOutlet UITableView *theTable;

@end
