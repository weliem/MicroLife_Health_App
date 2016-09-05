//
//  AboutViewController.m
//  MicroLifeApp
//
//  Created by Ideabus on 2016/8/11.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self goback3Btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goback3Btn{
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame = CGRectMake(0 , 0, self.view.frame.size.width, self.view.frame.size.height/10);
    titleBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.625 alpha:1];
    [titleBtn setTitle:@"About" forState:UIControlStateNormal];
    //[button setBackgroundColor:[UIColor blueColor]];
    [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //[gobackBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(goback3Click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:titleBtn];
    
    UIButton *gobackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gobackBtn.frame = CGRectMake(0 , 0, self.view.frame.size.height/10, self.view.frame.size.height/10);
    
    
    //[gobackBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [gobackBtn addTarget:self action:@selector(goback3Click) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:gobackBtn];
    
}

-(void)goback3Click{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}


@end
