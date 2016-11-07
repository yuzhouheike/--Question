//
//  ViewController.m
//  设置答题卡
//
//  Created by 王磊磊 on 2016/11/4.
//  Copyright © 2016年 Ceshi乐知行. All rights reserved.
//

#import "ViewController.h"
#import "QuestionCountView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    UIView *questionCountViewview = [[QuestionCountView alloc] initWithFrame:CGRectMake(20, 40, CGRectGetWidth(self.view.bounds) - 40, 600)];
    
    
    [self.view addSubview:questionCountViewview];
    
    NSLog(@"%@", questionCountViewview);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
