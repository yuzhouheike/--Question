//
//  QuestionCountView.h
//  设置答题卡
//
//  Created by 王磊磊 on 2016/11/4.
//  Copyright © 2016年 Ceshi乐知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionCountView : UIView

/** 题目数量 */
@property (nonatomic, assign) NSInteger questionCounter;

/** 题目数量字典 */
@property (nonatomic, strong) NSMutableDictionary *questionDictionary;

@end
