//
//  AnswerView.m
//  设置答题卡
//
//  Created by 王磊磊 on 2016/11/7.
//  Copyright © 2016年 Ceshi乐知行. All rights reserved.
//

#import "AnswerView.h"
#import "Masonry.h"
#define kMargin 10

@implementation AnswerView {
    
    UILabel *tempLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = [UIColor purpleColor];
    }
    return self;
}


- (void) answerViewWithNumber:(NSInteger)number answerCount:(NSInteger)answerCount{
    
    _numberOfQuestion = answerCount;
    
    UIView  *answerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 40)];
    answerView.tag = 1000 + number;
    
    tempLabel = [[UILabel alloc] init];
    tempLabel.frame = CGRectMake(0, 5, 80, 30);
    tempLabel.text = [NSString stringWithFormat:@"第%ld题", number] ;
    [answerView addSubview:tempLabel];
    
    NSArray *answesArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K"];
    CGFloat x ;
    CGFloat y = tempLabel.frame.origin.y;
    CGFloat width = 40;
    CGFloat height = 30;
    
    for (NSInteger index = 0; index < answerCount; index ++) {
        
        
        x = index * (width + kMargin) + 100;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor orangeColor];
        button.frame = CGRectMake(x, y, width, height);
        [button setTitle:answesArray[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"button_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"button_selected"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(answerButtonSelectedMethod:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000 * index + number;

        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"selected"] = [NSString stringWithFormat:@"%ld", (long)button.selected];
        
        [answerView addSubview:button];
        
    }
    
    UIButton *answerSubButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [answerSubButton setBackgroundImage:[[UIImage imageNamed:@"sub"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    answerSubButton.accessibilityLabel = @"answerSub";
    [answerSubButton addTarget:self action:@selector(answerSubOrSumButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    answerSubButton.tag = 100 * number + answerCount;
    
    UIButton *answerSumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [answerSumButton setBackgroundImage:[[UIImage imageNamed:@"sum"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [answerSumButton addTarget:self action:@selector(answerSubOrSumButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    answerSumButton.accessibilityLabel = @"answerSum";
    answerSumButton.tag = 100 * number + answerCount;
    
    [answerView addSubview:answerSumButton];
    [answerView addSubview:answerSubButton];
    
    [answerSumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(answerView.mas_right).offset(-kMargin * 4);
        make.top.equalTo(tempLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [answerSubButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(answerSumButton.mas_left).offset(-kMargin);
        make.top.equalTo(answerSumButton.mas_top);
        make.size.mas_equalTo(answerSumButton);
    }];
    
    [self addSubview:answerView];
}


#pragma mark - 题目的正确选项

- (void) answerButtonSelectedMethod:(UIButton *)button {
    
    button.selected = !button.selected;
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (button.selected) {
        
        [dictionary setValue:[NSNumber numberWithInteger:(button.tag / 1000)] forKey:[NSString stringWithFormat:@"第%ld题", (button.tag % 1000)]];
        [self.answerArray addObject:[NSString stringWithFormat:@"%ld", button.tag / 1000]];
        [self.answerArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            
            return obj1 > obj2;
        }];
        /**
         sortUsingDescriptors
         */

    }
    else {
        
        
        [dictionary setValue:[NSNumber numberWithInteger:(button.tag % 1000)] forKey:[NSString stringWithFormat:@"%ld", (button.tag / 1000)]];
  
    }
    
}

- (void)answerSubOrSumButtonMethod:(UIButton *)button {
    
    self.answerArray = [NSMutableArray array];
  
    NSInteger row = button.tag / 100;
    
    NSInteger col = button.tag % 100;
    
    if ([button.accessibilityLabel isEqualToString:@"answerSum"]) {
      
        if (col < 11) {
            [[(UIView *)self viewWithTag:(row + 1000)] removeFromSuperview];
            col = col + 1;
            [self answerViewWithNumber:self.orderOfQuestion answerCount:col];

        }
        
    }
    else if([button.accessibilityLabel isEqualToString:@"answerSub"]) {
  
        if (col > 4) {
            [[(UIView *)self viewWithTag:(row + 1000)] removeFromSuperview];
            col = col - 1;
            [self answerViewWithNumber:self.orderOfQuestion answerCount:col];


            [button removeFromSuperview];
        }
    }
    
}

#pragma mark - 设置第几题

- (void)setOrderOfQuestion:(NSInteger)orderOfQuestion {
    _orderOfQuestion = orderOfQuestion;
    
    [self answerViewWithNumber:_orderOfQuestion answerCount:4];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"题目序号：第%ld题 \n 题目个数：%ld  \n 答案数组%@",  self.orderOfQuestion, self.numberOfQuestion, self.answerArray];
}

#pragma mark - answerArray 

- (NSMutableArray *)answerArray {
    
    if (!_answerArray) {
        _answerArray = [NSMutableArray array];
    }
    return _answerArray;
}

@end
