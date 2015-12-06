//
//  gradeModule.h
//  gradeDemo
//
//  Created by llbt on 15/12/1.
//  Copyright © 2015年 llbt. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseObj)(NSArray *model);
typedef void(^ResponseString)(NSString *string);

@interface GradeModule : NSObject

@property(nonatomic, strong) NSDictionary *institudeDic;

- (void)getQueryCustomFieldChildsByPidOnSuccess:(ResponseObj)successBlock
                                             onFailure:(ResponseString)failureBlock;

@end
