//
//  gradeModule.m
//  gradeDemo
//
//  Created by llbt on 15/12/1.
//  Copyright © 2015年 llbt. All rights reserved.
//

#import "GradeModule.h"

@implementation GradeModule

//调用接口
- (void)getQueryCustomFieldChildsByPidOnSuccess:(ResponseObj)successBlock
                                             onFailure:(ResponseString)failureBlock
{
    NSString *mid = [_institudeDic objectForKey:@"id"];
    if (mid) {
        NSMutableArray *rv = [[NSMutableArray alloc]initWithCapacity:0];
        for (int i = 0; i < 6; i++) {
            [rv addObject:@{@"id":[NSString stringWithFormat:@"%d",i],
                            @"fieldValue":[NSString stringWithFormat:@"%@%d",mid,i]}];
        }
        successBlock(rv);
    }

}


@end
