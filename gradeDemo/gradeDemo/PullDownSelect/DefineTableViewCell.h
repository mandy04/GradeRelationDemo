//
//  DefineTableViewCell.h
//  packageSegment
//
//  Created by mandy on 15/5/26.
//  Copyright (c) 2015年 mandy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefineTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *selectView;
@property(nonatomic,strong)UILabel *textLabel;
@property(nonatomic,strong)UIImageView *nextView;
@property(nonatomic,strong)UIImageView *imgViewSelBg;

-(void)setCellBeSelected:(BOOL)selected;

@end
