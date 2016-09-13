//
//  MainReminderViewController.m
//  Microlife
//
//  Created by Rex on 2016/7/22.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "MainReminderViewController.h"
#import "CustomAlarmCell.h"
#import "SetAlarmViewController.h"

@interface MainReminderViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    UITableView *alarmTable;
    NSMutableArray *reminderArray;
}

@end

static NSString *identifier = @"AlarmCell";

@implementation MainReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initParameter];
    [self initInterface];
    
}

-(void)initParameter{
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    reminderArray = [[LocalData sharedInstance] getReminderData];
    
    NSLog(@"reminderArray = %@",reminderArray);
    
    [alarmTable reloadData];
    
    if (reminderArray.count == 0) {
        alarmTable.hidden = YES;
    }else{
        alarmTable.hidden = NO;
    }
}

-(void)initInterface{
    
    self.navigationItem.title = @"Reminder";
    
    //設定leftBarButtonItem(profileBt)
    UIButton *leftItemBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height)];
    
    [leftItemBt setImage:[UIImage imageNamed:@"all_btn_a_menu"] forState:UIControlStateNormal];
    
    [leftItemBt addTarget:self action:@selector(profileBtAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftItemBt];
    
    
    float clockImgWidth = 303/self.imgScale;
    float clockImgHeight = 316/self.imgScale;
    
    UIImageView *clockImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-clockImgWidth/2, self.view.frame.size.height*0.123, clockImgWidth, clockImgHeight)];
    
    clockImage.image = [UIImage imageNamed:@"reminder_pic"];
    
    [self.view addSubview:clockImage];
    

    UILabel *reminderIntro = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-self.view.frame.size.width*0.78/2, clockImage.frame.origin.y+clockImage.frame.size.height+SCREEN_HEIGHT*0.029, self.view.frame.size.width*0.78, self.view.frame.size.height*0.187)];
    
    UIFont *font = [UIFont systemFontOfSize:18.0];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setLineSpacing: 10.0];
    
    NSDictionary *attributes = @{ NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle };
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Set the time to remind you of doing\nnecessary things you may forget.\nJust tap add button to\ncreate new alarm." attributes:attributes];
    
    [reminderIntro setAttributedText: attributedString];
    
    reminderIntro.textAlignment = NSTextAlignmentCenter;
    
    reminderIntro.numberOfLines = 0;
    
    [self.view addSubview:reminderIntro];
    
    UIButton *addAlarmBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-SCREEN_WIDTH*0.2/2, reminderIntro.frame.origin.y+reminderIntro.frame.size.height+SCREEN_HEIGHT*0.029, SCREEN_WIDTH*0.2, SCREEN_WIDTH*0.2)];

    [addAlarmBtn setBackgroundImage:[UIImage imageNamed:@"overview_btn_a_add_m"] forState:UIControlStateNormal];
    
    [addAlarmBtn addTarget:self action:@selector(addAlarmAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addAlarmBtn];
    
    
    UIButton *navAddButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [navAddButton setBackgroundImage:[UIImage imageNamed:@"reminder_icon_a_add"] forState:UIControlStateNormal];
    
    [navAddButton addTarget:self action:@selector(addAlarmAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:navAddButton];
    
    alarmTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    
    alarmTable.delegate = self;
    alarmTable.dataSource = self;
    
    [self.view addSubview:alarmTable];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return reminderArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //custom cell 需要給 height 才能顯示
    //return SCREEN_HEIGHT*0.176;
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomAlarmCell *alarmCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (alarmCell == nil) {
        alarmCell = [[CustomAlarmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    int model = [[[reminderArray objectAtIndex:indexPath.row] objectForKey:@"model"] intValue];
    
    UIImage *modelImg;
    NSString *typeText;
    
    switch (model) {
        case 0:
            modelImg = [UIImage imageNamed:@"reminder_icon_a_bp"];
            typeText = @"BP";
            break;
            
        case 1:
            modelImg = [UIImage imageNamed:@"reminder_icon_a_we"];
            typeText = @"Weight";
            break;
            
        case 2:
            modelImg = [UIImage imageNamed:@"reminder_icon_a_bt"];
            typeText = @"Body Temp.";
            break;
            
        default:
            break;
    }
    
    NSString *alarmHour = [NSString stringWithFormat:@"%@",[[reminderArray objectAtIndex:indexPath.row] objectForKey:@"hour"]];
    
    NSString *alarmMin = [NSString stringWithFormat:@"%@",[[reminderArray objectAtIndex:indexPath.row] objectForKey:@"min"]];
    
    NSMutableArray *chooseWeek = [[reminderArray objectAtIndex:indexPath.row] objectForKey:@"week"];
    
    NSString *weekStr = @"";
    
    for (int i=0; i<chooseWeek.count; i++) {
        
        if([[[chooseWeek objectAtIndex:i] objectForKey:@"choose"] boolValue]){
            weekStr = [weekStr stringByAppendingFormat:@"%@",[[chooseWeek objectAtIndex:i] objectForKey:@"weekName"]];
            NSLog(@"weekStr = %@",weekStr);
            
        }
    }

    
    NSMutableArray *chooseType = [[reminderArray objectAtIndex:indexPath.row] objectForKey:@"type"];
    
    NSString *typeStr;
    
    for (int i=0; i<chooseType.count; i++) {
        
        if([[[chooseType objectAtIndex:i] objectForKey:@"choose"] boolValue]){
            typeStr = [[chooseType objectAtIndex:i] objectForKey:@"typeName"];
            
        }
    }
    
    //NSString *typeStr = [NSString stringWithFormat:@"%@",[[reminderArray objectAtIndex:indexPath.row] objectForKey:@"type"]];
    
    BOOL switchOn = [[[reminderArray objectAtIndex:indexPath.row] objectForKey:@"status"] boolValue];
    
    if (indexPath.row == 0) {
        
        alarmCell.iconImage.image = modelImg;
        alarmCell.typeTitle.text = typeText;
        alarmCell.timeLabel.text = [NSString stringWithFormat:@"%@:%@",alarmHour,alarmMin];
        alarmCell.measureWeek.text = [NSString stringWithFormat:@"%@, %@",typeStr,weekStr];
        
        if(switchOn){
            alarmCell.alarmSwitch.on = YES;
        }else{
            alarmCell.alarmSwitch.on = NO;
        }
        
    }
    
    return alarmCell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SetAlarmViewController *setAlarmVC = [[SetAlarmViewController alloc] init];
    
    setAlarmVC.isCreate = NO;
    setAlarmVC.alarmIndex = indexPath.row;
    
    NSLog(@"setAlarmVC.alarmIndex = %d",setAlarmVC.alarmIndex);
    
    [self.navigationController pushViewController:setAlarmVC animated:YES];
}

#pragma mark - Navigation Action

-(void)backToReminderVC{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addAlarmAction{
    
    SetAlarmViewController *addReminderVC = [[SetAlarmViewController alloc] init];
    
    addReminderVC.isCreate = YES;
    addReminderVC.alarmIndex = reminderArray.count+1;
    
    [self.navigationController pushViewController:addReminderVC animated:YES];
    
}

#pragma mark - profileBtAction (導覽列左邊按鍵方法)
-(void)profileBtAction {
    
    [self SidebarBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
