//
//  QuestionCountView.m
//  设置答题卡
//
//  Created by 王磊磊 on 2016/11/4.
//  Copyright © 2016年 Ceshi乐知行. All rights reserved.
//

#import "QuestionCountView.h"
#import "Masonry.h"
#define kMargin 10


@implementation QuestionCountView {
    
    UILabel *_questionCountLabel;
    UIButton *_questionSubButton;
    UILabel *_numberOfQuestionLabel;
    UIButton *_questionSumButton;
    UIView *_blackView;
    CGFloat _answerCount;
    UILabel *tempLabel;
    NSMutableDictionary *buttonDict;
    NSMutableArray *_resultDictArray;
    
}

#pragma mark - lifecycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _questionDictionary = [NSMutableDictionary dictionary];
        _resultDictArray = [NSMutableArray array];
        buttonDict = [NSMutableDictionary dictionary];
        
        _questionCounter = 1;
        _answerCount = 4;
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
        
        UIView *view = [self answerViewWithNumber:1 answerCount:4];
        
        [self addSubview:view];
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


#pragma mark - 答题卡视图绘制

- (UIView *) answerViewWithNumber:(NSInteger)number answerCount:(NSInteger)answerCount{

    
//        NSDictionary *dict = @{@"answerCount":[NSNumber numberWithInteger:answerCount]};
//        _resultDictArray[number] = dict;
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
            
            _questionDictionary[@"questionCount"] = [NSNumber numberWithInteger:_questionCounter];
            
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
    
    NSLog(@"%@", button.accessibilityLabel);
    
    NSString *result = button.accessibilityLabel;
    
    if ([result isEqualToString:@"-"] && _questionCounter > 1) {
        
        [(UIView *)[self viewWithTag:_questionCounter + 1000] removeFromSuperview];
        _questionCounter = _questionCounter - 1;
    }
    else if ([result isEqualToString:@"+"]) {
        
        _questionCounter = _questionCounter + 1;
        [self addSubview:[self answerViewWithNumber:_questionCounter answerCount:4]];
    }
    
    _numberOfQuestionLabel.text = [NSString stringWithFormat:@"%ld", (long)_questionCounter];
    NSLog(@"%ld", (long)_questionCounter);
    NSLog(@"%@", _resultDictArray);
}


#pragma mark - 题目的正确选项

- (void) answerButtonSelectedMethod:(UIButton *)button {
    
    button.selected = !button.selected;
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (button.selected) {
        NSLog(@"第%ld行 第%ld列", button.tag % 1000, button.tag / 1000);
        
        [dictionary setValue:[NSNumber numberWithInteger:(button.tag / 1000)] forKey:[NSString stringWithFormat:@"第%ld题", (button.tag % 1000)]];
        
        [_resultDictArray addObject:dictionary];
    }
    else {
        
        NSLog(@"第%ld行 第%ld列", button.tag % 1000, button.tag / 1000);
        
        [dictionary setValue:[NSNumber numberWithInteger:(button.tag % 1000)] forKey:[NSString stringWithFormat:@"%ld", (button.tag / 1000)]];
        
        [_resultDictArray removeObject:dictionary];

    }
    
    NSLog(@"%@", _resultDictArray);
}

- (void)answerSubOrSumButtonMethod:(UIButton *)button {
    
    NSLog(@"%@", button.accessibilityLabel);

    NSLog(@"%ld", button.tag / 100);
    
    NSInteger row = button.tag / 100;
    
    NSInteger col = button.tag % 100;
    
    if ([button.accessibilityLabel isEqualToString:@"answerSum"]) {
        
        NSLog(@"");
        if (col < 11) {
            [[(UIView *)self viewWithTag:(row + 1000)] removeFromSuperview];
            col = col + 1;
            [self addSubview:[self answerViewWithNumber:row answerCount:col]];
        }
        
    }
    else if([button.accessibilityLabel isEqualToString:@"answerSub"]) {
       
        NSLog(@"");
        if (col > 4) {
            [[(UIView *)self viewWithTag:(row + 1000)] removeFromSuperview];
            col = col - 1;
            [self addSubview:[self answerViewWithNumber:row answerCount:col]];
        }
    }
    
    NSLog(@"%@", _resultDictArray);
}

@end
