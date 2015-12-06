//
//  gradeModel.m
//  gradeDemo
//
//  Created by llbt on 15/12/1.
//  Copyright © 2015年 llbt. All rights reserved.
//

#import "GradeViewModel.h"

@implementation GradeViewModel

- (id)init {
    self = [super init];
    if (self) {
        self.selectIndexs = [[NSMutableArray alloc]initWithCapacity:0];
        self.dataDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

//获取末尾选择的值
-(NSString *)selectedId
{
    if (_selectIndexs.count > 1)
    {
        NSArray *arr = _dataDic[[NSString stringWithFormat:@"%2u",_selectIndexs.count - 1]];
        return arr[[_selectIndexs[_selectIndexs.count - 1] intValue]][@"id"];
    }
    else if(_selectIndexs.count > 0 && _selectIndexs[0] > 0)
    {
        NSArray *arr = _dataDic[@" 0"];
        return arr[[_selectIndexs[0] intValue]][@"id"];
    }
    return nil;
}

//获取各个层级的选项
-(NSArray *)selectedIdList
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
    
    if (_selectIndexs.count > 0)
    {
        for (int i = 0;i < _selectIndexs.count;i++) {
            NSString *idstr = _selectIndexs[i];
            if ([idstr isEqualToString:@"-1"]) {
                return array;
            }
            NSArray *arr = _dataDic[[NSString stringWithFormat:@"%2d",i]];
            NSString *selectID = arr[[idstr intValue]][@"id"];
            [array addObject:selectID];
        }
    }
    return array;
}


@end
