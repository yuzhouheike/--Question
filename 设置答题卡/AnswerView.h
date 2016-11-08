//
//  AnswerView.h
//  设置答题卡
//
//  Created by 王磊磊 on 2016/11/7.
//  Copyright © 2016年 Ceshi乐知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerView : UIView

/** 答案数组 */
@property (nonatomic, strong) NSMutableArray *answerArray;

/** 题目个数 */
@property (nonatomic, assign) NSInteger numberOfQuestion;

/** 第几题 */
@property (nonatomic, assign) NSInteger orderOfQuestion;

@end
