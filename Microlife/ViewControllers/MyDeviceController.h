//
//  MyDeviceController.h
//  Microlife
//
//  Created by Idea on 2016/10/7.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeasureCell.h"
#import "MainSettingViewController.h"

@interface MyDeviceController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *MeasureTV;
    UILabel *deviceLabel;
    
    
}

@property (nonatomic,retain) UILabel *deviceLabel;
@property (nonatomic,retain) NSString *deviceStr;

@end
