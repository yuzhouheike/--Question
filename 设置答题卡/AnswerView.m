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
        
        [self answerViewWithNumber:1 answerCount:4];
    }
    return self;
}


- (UIView *) answerViewWithNumber:(NSInteger)number answerCount:(NSInteger)answerCount{
    
    
    UIView  *answerView = [[UIView alloc] initWithFrame:CGRectMake(30, 50 + (40 + kMargin) * number, CGRectGetWidth(self.bounds), 40)];
    answerView.tag = 1000 + number;
    
    tempLabel = [[UILabel alloc] init];
    tempLabel.frame = CGRectMake(kMargin, 30, 80, 30);
    tempLabel.text = [NSString stringWithFormat:@"第%ld题", number] ;
    [answerView addSubview:tempLabel];
    
    NSArray *answesArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K"];
    CGFloat x ;
    CGFloat y = tempLabel.frame.origin.y;
    CGFloat width = 40;
    CGFloat height = 30;
    
    for (NSInteger index = 0; index < answerCount; index ++) {
        
//        _questionDictionary[@"questionCount"] = [NSNumber numberWithInteger:_questionCounter];
        
        x = index * (width + kMargin) + 100;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
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
    
    return answerView;
}

#pragma mark - 题目数量的增加或者减少

- (void)questionSubButtonMethod:(UIButton *)button {
    

}





@end
