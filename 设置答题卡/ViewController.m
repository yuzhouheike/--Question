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

/** ceshi */
@property (nonatomic, weak) QuestionCountView *questionCountViewview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    QuestionCountView *questionCountViewview = [[QuestionCountView alloc] init];
    _questionCountViewview = questionCountViewview;
    [self.view addSubview:questionCountViewview];
    NSLog(@"%@", questionCountViewview.answerViewArray);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"从控制器里面调用%@", _questionCountViewview.answerViewArray);
}

@end
