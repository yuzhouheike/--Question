//
//  QuestionCountView.m
//  设置答题卡
//
//  Created by 王磊磊 on 2016/11/4.
//  Copyright © 2016年 Ceshi乐知行. All rights reserved.
//

#import "QuestionCountView.h"
#import "AnswerView.h"
#import "Masonry.h"
#define kMargin 10


@implementation QuestionCountView {
    
    UILabel *_questionCountLabel;
    UIButton *_questionSubButton;
    UILabel *_numberOfQuestionLabel;
    UIButton *_questionSumButton;
    UIView *_blackView;
    UILabel *tempLabel;
    /** 题目数量 */
    NSInteger _questionCounter;
    
}

#pragma mark - lifecycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(20, 40, [UIScreen mainScreen].bounds.size.width - 40, 120)];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        
        _questionCounter = 1;
        _questionCountLabel = [[UILabel alloc] init];
        _questionCountLabel.text = @"题目数量:";
        
        _questionSubButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_questionSubButton setTitle:@"-" forState:UIControlStateNormal];
        [_questionSubButton addTarget:self action:@selector(questionSubButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
        [_questionSubButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _questionSubButton.accessibilityLabel = @"-";
        _questionSubButton.layer.borderWidth = 0.5;
        _questionSubButton.layer.cornerRadius = 10;
        
        _numberOfQuestionLabel = [[UILabel alloc] init];
        _numberOfQuestionLabel.textAlignment = NSTextAlignmentCenter;
        _numberOfQuestionLabel.layer.borderWidth = 0.5;
        _numberOfQuestionLabel.text = [NSString stringWithFormat:@"%ld", (long)_questionCounter];
        _numberOfQuestionLabel.backgroundColor = [UIColor whiteColor];
        
        
        _questionSumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_questionSumButton setTitle:@"+" forState:UIControlStateNormal];
        [_questionSumButton addTarget:self action:@selector(questionSubButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
        [_questionSumButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _questionSumButton.accessibilityLabel = @"+";
        _questionSumButton.layer.borderWidth = 0.5;
        _questionSumButton.layer.cornerRadius = 10;
        
        _blackView = [[UIView alloc] init];
        _blackView.backgroundColor = [UIColor blackColor];
        
        [self addSubview:_questionCountLabel];
        [self addSubview:_questionSubButton];
        [self addSubview:_questionSumButton];
        [self addSubview:_numberOfQuestionLabel];
        [self addSubview:_blackView];
        
        AnswerView *answerView = [[AnswerView alloc] initWithFrame:CGRectMake(0, (self.answerViewArray.count + 3) * 60, CGRectGetWidth(self.bounds), 50)];
        answerView.orderOfQuestion = 1;
        [self addSubview:answerView];
        [self.answerViewArray addObject:answerView];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [_questionCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(kMargin);
        make.left.equalTo(self).offset(kMargin);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [_questionSubButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_questionCountLabel.mas_right).offset(kMargin * 4);
        make.top.equalTo(_questionCountLabel);
        make.height.equalTo(_questionCountLabel);
        make.width.equalTo(@60);
    }];
    
    [_numberOfQuestionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_questionSubButton);
        make.left.equalTo(_questionSubButton.mas_right).offset(-10);
        make.bottom.equalTo(_questionSubButton);
        make.width.equalTo(@100);
    }];
    
    [_questionSumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(_numberOfQuestionLabel);
        make.width.equalTo(_questionSubButton);
        make.left.equalTo(_numberOfQuestionLabel.mas_right).offset(-10);
    }];
    
    [_blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_questionCountLabel.mas_bottom).offset(5);
        make.right.left.with.equalTo(self);
        make.height.equalTo(@1);
    }];
    
}



#pragma mark - 题目数量的增加或者减少

- (void)questionSubButtonMethod:(UIButton *)button {
    
    NSLog(@"%@", button.accessibilityLabel);
    
    NSString *result = button.accessibilityLabel;
    
    if ([result isEqualToString:@"-"] && _questionCounter > 1) {

        CGRect frame = self.frame;
        CGSize size = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) -   40);
        frame.size = size;
        self.frame = frame;
        _questionCounter = _questionCounter - 1;
        /**
         删除最后一个anserView
         */
        AnswerView *answerView = self.answerViewArray[self.answerViewArray.count - 1];
        [answerView removeFromSuperview];
        [self.answerViewArray removeObjectAtIndex:(self.answerViewArray.count -1)];
//        [self]
    }
    else if ([result isEqualToString:@"+"]) {
        
        _questionCounter = _questionCounter + 1;
        CGRect frame = self.frame;
        CGSize size = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) +40);
        frame.size = size;
        self.frame = frame;
        /**
         增加一个anserView到最后
         */
        AnswerView *answerView = [[AnswerView alloc] initWithFrame:CGRectMake(0, (self.answerViewArray.count + 3) * 60, CGRectGetWidth(self.bounds), 50)];
        answerView.orderOfQuestion = self.answerViewArray.count + 1;
        [self addSubview:answerView];
        [self.answerViewArray addObject:answerView];
        
    }
    
    _numberOfQuestionLabel.text = [NSString stringWithFormat:@"%ld", (long)_questionCounter];
    
    NSLog(@"%@", self.answerViewArray);
    
    
   
}

- (void)setQuestionCounter:(NSInteger)questionCounter {
    
    _numberOfQuestionLabel.text = [NSString stringWithFormat:@"%ld", (long)_questionCounter];

}

- (NSMutableArray *)answerViewArray {
    
    if (!_answerViewArray) {
        _answerViewArray = [NSMutableArray array];
      
    }
    
    return _answerViewArray;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@", self.answerViewArray];
}

@end
