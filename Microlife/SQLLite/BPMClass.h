//
//  BPMClass.h
//  Microlife
//
//  Created by Rex on 2016/10/6.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "DataBaseClass.h"

@interface BPMClass : DataBaseClass

@property (nonatomic) int BPM_ID;                   //血壓機ID
@property (nonatomic) int accountID;                //會員ID
@property (nonatomic) int SYS;                      //收縮壓
@property (nonatomic) int DIA;                      //舒張壓
@property (nonatomic) int PUL;                      //脈搏
@property (nonatomic) int PAD;                      //心律不整
@property (nonatomic) int AFIB;                     //心房顫動
@property (nonatomic) int SYS_Unit;                 //收縮壓單位 0=mmHg/1=kpa
@property (nonatomic) int PUL_Unit;                 //心律單位 0=Beats/1=Min

@property (nonatomic) NSString *date;               //日期
@property (nonatomic) NSString * BPM_PhotoPath;     //筆記照片路徑
@property (nonatomic) NSString * BPM_Note;          //筆記內容
@property (nonatomic) NSString * BPM_RecordingPath; //筆記錄音路徑


+(BPMClass*) sharedInstance;

-(NSDictionary *)selectAllData;
-(NSMutableArray *)selectBPWithRange:(int)dataRange count:(int)dataCount;
-(NSMutableArray *)selectPULWithRange:(int)dataRange count:(int)dataCount;
-(NSMutableArray *)selectSingleDayPULWithRange:(int)dataRange;
-(NSMutableArray *)selectSingleDayBPWithRange:(int)dataRange;

-(void)insertData;
- (void)updateData;

@end
