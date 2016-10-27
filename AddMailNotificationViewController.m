//
//  AddMailNotificationViewController.m
//  Setting
//
//  Created by Ideabus on 2016/8/17.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "AddMailNotificationViewController.h"

@interface AddMailNotificationViewController ()

@end

@implementation AddMailNotificationViewController
@synthesize addEmailTextField;
@synthesize addNameTextField;
@synthesize nameString,emailString;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addV];
    [self addMnav];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addMnav{
    
    UIView *pnavview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.09)];
    pnavview.backgroundColor = [UIColor colorWithRed:0 green:61.0f/255.0f blue:165.0f/255.0f alpha:1.0];
    [self.view addSubview:pnavview];
    
    
    CGRect pnavFrame = CGRectMake(0, 0 , self.view.frame.size.width , self.view.frame.size.height*0.1);
    UILabel *pnavLabel = [[UILabel alloc] initWithFrame:pnavFrame];
    [pnavLabel setTextColor:[UIColor whiteColor ]];
    pnavLabel.backgroundColor = [UIColor clearColor];
    pnavLabel.text = @"Add Mail Notification";
    pnavLabel.font = [UIFont systemFontOfSize:22];
    pnavLabel.alpha = 1.0;
    pnavLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:pnavLabel];
    
    
    UIButton *navbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navbackBtn.frame = CGRectMake(0, self.view.frame.size.height*0.026, self.view.frame.size.height*0.05, self.view.frame.size.height*0.05);
    [navbackBtn setImage:[UIImage imageNamed:@"all_btn_a_cancel"] forState:UIControlStateNormal ];
    
    navbackBtn.backgroundColor = [UIColor clearColor];
    navbackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [navbackBtn addTarget:self action:@selector(gobackMailNotification) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:navbackBtn];
    
    UIButton *navsaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navsaveBtn.frame = CGRectMake(self.view.frame.size.width*0.78, self.view.frame.size.height*0.02, self.view.frame.size.width/5, self.view.frame.size.height*0.07);
    [navsaveBtn setTitle:@"Save" forState:UIControlStateNormal];
    [navsaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    navsaveBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    navsaveBtn.backgroundColor = [UIColor clearColor];
    navsaveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //navbackBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
    [navsaveBtn addTarget:self action:@selector(saveAdd) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:navsaveBtn];
    
    
    
}


-(void)saveAdd{
    
    
    
    if (addNameTextField.text.length < 1 || addEmailTextField.text.length < 1) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"The name can not be null! " message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *ConfirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler: ^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:ConfirmAction];
        
        
        UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:closeAction];
        
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        
        NSLog(@"emailString = %@",emailString);
        //Save
        NSDictionary *memberDict = [[NSDictionary alloc] initWithObjectsAndKeys:       addNameTextField.text,@"name",
                                    addEmailTextField.text,@"email",nil];
        
        [[LocalData sharedInstance] saveMemberProfile:memberDict];
        
        
        //Get prev page
        
        //NSMutableArray *array = [[LocalData sharedInstance] returnMemberProfile];
        
        
        
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];

        
    }
    

       
}



-(void)gobackMailNotification{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)addV{
    
    float addH = self.view.frame.size.height*0.09;
    float addY = self.view.frame.size.height*0.16;
    
    [self.view setBackgroundColor:[UIColor colorWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:1.0]];
    
    UIView *addview = [[UIView alloc]initWithFrame:CGRectMake(-1, addY, self.view.frame.size.width+2, addH*2+1)];
    addview.backgroundColor = [UIColor whiteColor];
    addview.layer.borderWidth = 1;
    addview.layer.borderColor = [UIColor colorWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1.0].CGColor;
    
    [self.view addSubview:addview];
    
    UIView *aline = [[UIView alloc]initWithFrame:CGRectMake(0, addY+addH, self.view.frame.size.width, 1)];
    
    aline.backgroundColor = [UIColor colorWithRed:208.0f/255.0f green:208.0f/255.0f blue:208.0f/255.0f alpha:1];
    [self.view addSubview:aline];
    
    
    // UITextField初始化
    addNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.25 , addY+1, self.view.frame.size.width, addH-1)];
    // 設定預設文字內容
    addNameTextField.placeholder = @"";
    //emailTextField.text = @"";
    
    addNameTextField.secureTextEntry = NO;
    // 設定文字顏色
    addNameTextField.textColor = [UIColor blackColor];
    // Delegate
    addNameTextField.delegate = self;
    // 設定輸入框背景顏色
    addNameTextField.backgroundColor = [UIColor whiteColor];
    //    设置背景图片
    //    textField.background=[UIImage imageNamed:@"test.png"];
    // 框線樣式
    addNameTextField.borderStyle =  UITextBorderStyleNone;
    //设置文本对齐方式
    addNameTextField.textAlignment = NSTextAlignmentJustified;
    //设置字体
    addNameTextField.font = [UIFont systemFontOfSize:26];
    //设置编辑框中删除按钮的出现模式
    addNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    //設置鍵盤格式
    [addNameTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    //設置首字不大寫
    addNameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;

    [self.view addSubview:addNameTextField];
    
    [addNameTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    // UITextField初始化
    addEmailTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.25 , addY+addH+1, self.view.frame.size.width, addH-1)];
    // 設定預設文字內容
    addEmailTextField.placeholder = @"";
    //emailTextField.text = @"";
    addEmailTextField.secureTextEntry = NO;
    // 設定文字顏色
    addEmailTextField.textColor = [UIColor blackColor];
    // Delegate
    addEmailTextField.delegate = self;
    // 設定輸入框背景顏色
    addEmailTextField.backgroundColor = [UIColor whiteColor];
    //    设置背景图片
    //    textField.background=[UIImage imageNamed:@"test.png"];
    // 框線樣式
    addEmailTextField.borderStyle =  UITextBorderStyleNone;
    //设置文本对齐方式
    addEmailTextField.textAlignment = NSTextAlignmentJustified;
    //设置字体
    addEmailTextField.font = [UIFont systemFontOfSize:26];
    //设置编辑框中删除按钮的出现模式
    addEmailTextField.clearButtonMode = UITextFieldViewModeAlways;
    //設置鍵盤格式
    [addEmailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    //設置首字不大寫
    addEmailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [self.view addSubview:addEmailTextField];
    
    [addEmailTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, addY+1, self.view.frame.size.width*0.25, addH-1)];
    [nameLabel setTextColor:[UIColor blackColor ]];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = @"Name";
    nameLabel.font = [UIFont systemFontOfSize:22];
    nameLabel.alpha = 1.0;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:nameLabel];
    

    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.05, addY+addH+1, self.view.frame.size.width*0.25, addH-1)];
    [emailLabel setTextColor:[UIColor blackColor ]];
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.text = @"Email";
    emailLabel.font = [UIFont systemFontOfSize:22];
    emailLabel.alpha = 1.0;
    emailLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:emailLabel];
    
    
}




//限制輸入字數
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (addNameTextField == textField)//这个 if 判断是在多个输入框的时候,只限制一个输入框的时候用的,如果全部限制,则不加 if 判断即可,这里是只判断输入用户名的输入框
    {
        if ([aString length] > 50) {
            textField.text = [aString substringToIndex:50];
            
            return NO;
        }
    }
    
    
    return YES;
}


// 設定delegate 為self後，可以自行增加delegate protocol
// 開始進入編輯狀態
- (void) textFieldDidBeginEditing:(UITextField*)textField {
    NSLog(@"textFieldDidBeginEditing:%@",textField.text);
}

// 可能進入結束編輯狀態
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"textFieldShouldEndEditing:%@",textField.text);
    return true;
}

// 結束編輯狀態(意指完成輸入或離開焦點)
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textFieldDidEndEditing:%@",textField.text);
    
    nameString = addNameTextField.text;
    emailString = addEmailTextField.text;
    
    NSLog(@"did endemailString = %@",addEmailTextField.text);
    
}


// 按下Return後會反應的事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //利用此方式讓按下Return後會Toogle 鍵盤讓它消失
    [textField resignFirstResponder];
    NSLog(@"按下Return");
    nameString = addNameTextField.text;
    emailString = addEmailTextField.text;
    
    NSLog(@"should emailString = %@",addEmailTextField.text);
    return false;
}

-(void)textFieldChanged :(UITextField *) textField{
    
}



-(void)textFieldDone:(UITextField*)textField
{
    [textField resignFirstResponder];
}










@end
