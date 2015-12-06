//
//  gradeModel.h
//  gradeDemo
//
//  Created by llbt on 15/12/1.
//  Copyright © 2015年 llbt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GradeViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *selectIndexs;
@property (nonatomic, strong) NSMutableDictionary *dataDic;

- (NSString *)selectedId;
- (NSArray *)selectedIdList;//获取各个层级的选项


@end
