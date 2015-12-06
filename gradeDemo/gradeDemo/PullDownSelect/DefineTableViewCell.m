//
//  DefineTableViewCell.m
//  packageSegment
//
//  Created by mandy on 15/5/26.
//  Copyright (c) 2015年 mandy. All rights reserved.
//

#import "DefineTableViewCell.h"
#define ImgageViewFrame CGRectMake(2, 5, 20, 20)
#define ImageViewHeight 20
#define ImgageViewWidth 20
#define kCellWidth self.frame.size.width
#define kCellHeight self.frame.size.height

@implementation DefineTableViewCell
@synthesize selectView,textLabel,nextView,imgViewSelBg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
    }
    return self;
}
-(void)setUp {
    textLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, -5, kCellWidth, kCellHeight-4)];
    textLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:textLabel];
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellBeSelected:(BOOL)selected {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

