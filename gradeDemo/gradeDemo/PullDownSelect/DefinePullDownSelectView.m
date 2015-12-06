//
//  DefinePullDownSelectView.m
//  packageSegment
//
//  Created by mandy on 15/5/25.
//  Copyright (c) 2015年 mandy. All rights reserved.
//

#import "DefinePullDownSelectView.h"
#import "DefineTableViewCell.h"
#define kCellHeight 24.0f

@implementation DefinePullDownSelectView
@synthesize _dataArray,_locationArr,delegete = _delegete;
@synthesize _bgImageView,_selectLabel,_selectRow;
@synthesize _isOnlySelect,_isRequestData,_isSelectShow;

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title andDataArray:(NSArray *)dataArray inView:(UIView *)aView {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        _frame = frame;
        _parentView = aView;
        _dataArray = dataArray;
        self.clipsToBounds = YES;
        _isSelectShow = NO;
        
        UIImage *image = [UIImage imageNamed:@"selectIcon"];
        image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        self.image  = image;
        
        _selectLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, (frame.size.height-20)/2, frame.size.width-10*2, 20)];
        _selectLabel.text = title;
        _selectLabel.font = [UIFont systemFontOfSize:14.0f];
        _selectLabel.textColor = [UIColor grayColor];
        _selectLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_selectLabel];

        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-10-13, (frame.size.height-9)/2, 13, 9)];
        _bgImageView.image = [UIImage imageNamed:@"pullDown_arrow"];
        [self addSubview:_bgImageView];

        _menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(5, frame.size.height, frame.size.width-10, dataArray.count*kCellHeight) style:UITableViewStylePlain];
        if (!_dataArray.count) {//默认显示一个cell的高度
            CGRect frame = _menuTableView.frame;
            frame.size.height = kCellHeight;
            _menuTableView.frame = frame;
        }
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.backgroundColor = [UIColor clearColor];
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

        _backScrollView = [[UIScrollView alloc]initWithFrame:_menuTableView.frame];
        [self addSubview:_backScrollView];
        [_backScrollView addSubview:_menuTableView];
        _backScrollView.showsVerticalScrollIndicator = YES;
        _backScrollView.showsHorizontalScrollIndicator = NO;
        _backScrollView.bounces = NO;

        CGRect frame = _backScrollView.frame;
        if (dataArray.count) {
            frame.size.height = dataArray.count *kCellHeight;
            if (dataArray.count>10)
            {
                if (frame.size.height>150) {
                    _menuTableView.scrollEnabled = YES;
                    frame.size.height = 250;
                }
            }else{
                if (frame.size.height>350) {
                    _menuTableView.scrollEnabled = YES;
                    frame.size.height = 350;
                  }
            }

        }else{
                frame.size.height = kCellHeight;
        }
        _backScrollView.frame = frame;
        _menuTableView.frame = _backScrollView.bounds;
        _backScrollView.contentSize = _backScrollView.bounds.size;


        _hiddenTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenTableView)];
        _hiddenTapGesture.delegate = self;

    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andDefaultSelectRow:(NSInteger)selectRow andDataArray:(NSArray *)dataArray inView:(UIView *)aView {
    self= [self initWithFrame:frame andTitle:@"" andDataArray:dataArray inView:aView];
    if (self) {
        _selectRow = selectRow;
        if (selectRow>=0 &&selectRow<dataArray.count) {
            _selectLabel.text = [dataArray objectAtIndex:_selectRow];
        }
    }
    return self;
}
//后台请求的
-(id)initWithFrame:(CGRect)frame andRequestDataArray:(NSArray *)dataArray andDefaultSelectRow:(NSInteger)selectRow inView:(UIView *)aView {
    self = [self initWithFrame:frame andTitle:@"" andDataArray:dataArray inView:aView];
    if (self) {
        _isRequestData = YES;
        _selectRow = selectRow;
        if (selectRow>=0&&selectRow<dataArray.count) {
            _selectLabel.text = [[dataArray objectAtIndex:_selectRow]objectForKey:@"OptionValue"];
        }
    }
    return self;
}

- (void)reloadDataArray:(NSArray *)reloadDataArray andDefaultSelectRow:(NSInteger)defaultSelectRow {
    _selectRow = defaultSelectRow;
    _dataArray = reloadDataArray;
    if (defaultSelectRow>=0&&defaultSelectRow<reloadDataArray.count) {
        @try {
            id obj = [reloadDataArray objectAtIndex:_selectRow];
            if ([obj isKindOfClass:[NSString class]]) {
                _selectLabel.text = [reloadDataArray objectAtIndex:defaultSelectRow];
            }else if ([obj isKindOfClass:[NSDictionary class]]){
                _selectLabel.text = [[reloadDataArray objectAtIndex:_selectRow]objectForKey:@"OptionValue"];
            }else{
                _selectLabel.text = @"";
            }
        }
        @catch (NSException *exception) {
            _selectLabel.text = [NSString stringWithFormat:@"%@",[reloadDataArray objectAtIndex:defaultSelectRow]];
        }
        @finally {
          //
        }
    }else {
        _selectLabel.text = @"";
    }

    CGRect frame = _backScrollView.frame;
    if (_dataArray.count) {
        frame.size.height = reloadDataArray.count *kCellHeight;
        if (reloadDataArray.count>10)
        {
            if (frame.size.height>150) {
                _menuTableView.scrollEnabled = YES;
                frame.size.height = 250;
            }
        }else{
            if (frame.size.height>350) {
                _menuTableView.scrollEnabled = YES;
                frame.size.height = 350;
            }
        }

    }else{
        frame.size.height = kCellHeight;
    }
    _backScrollView.frame = frame;
    _menuTableView.frame = _backScrollView.bounds;
    _backScrollView.contentSize = _backScrollView.bounds.size;
    [_menuTableView reloadData];

}

#pragma mark delegate/dataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataArray) {
        return _dataArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    DefineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell =[[DefineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    if (_dataArray) {
        NSString *text = nil;
        if (_isRequestData) {
            text = [[_dataArray objectAtIndex:indexPath.row]objectForKey:@"OptionValue"];
        }else{
            text = [_dataArray objectAtIndex:indexPath.row];//默认将数组里根据每一行取出来
            if ([text isKindOfClass:[NSDictionary class]]) {
                text = [(NSDictionary *)text objectForKey:@"OptionValue"];
            }else if (![text isKindOfClass:[NSString class]]) {
                text = @"";
            }
        }
        cell.textLabel.text = text;
        //CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:cell.textLabel.font]];
        CGSize textSize =[text sizeWithAttributes:@{NSFontAttributeName :cell.textLabel.font}];
        if (textSize.width+40>CGRectGetWidth(tableView.frame)) {
            CGRect tableFrame = tableView.frame;
            tableFrame.size.width = textSize.width +40;
            tableView.frame = tableFrame;
            _backScrollView.contentSize = tableFrame.size;
        }
    }
    return cell;
}

//选择后更新标题显示
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //收起下拉列表
    [self hiddenTableView];
    DefineTableViewCell *cell = (DefineTableViewCell*)[_menuTableView  cellForRowAtIndexPath:indexPath];
    _selectLabel.text = cell.textLabel.text;
    _selectRow = indexPath.row;
    
    if (_isRequestData) {
        if (_delegete && [_delegete respondsToSelector:@selector(selectView:didSelectOptionKey:)]) {
            [_delegete selectView:self didSelectOptionKey:[[_dataArray objectAtIndex:indexPath.row] objectForKey:@"OptionKey"]];
        }
        if (_delegete && [_delegete respondsToSelector:@selector(selectView:didSelectOptionDictionary:)]) {
            [_delegete selectView:self didSelectOptionDictionary:[_dataArray objectAtIndex:indexPath.row]];
        }
    }else {
        if (_delegete && [_delegete respondsToSelector:@selector(selectView:didSelectRowAtIndexPath:)]) {
            [_delegete selectView:self didSelectRowAtIndexPath:indexPath];
        }
    }
}

//点击在下拉视图内部时手势不拦截点击事件 在外部拦截
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.bounds, point)) {
        return NO;
    }
    return YES;
}



//点击时显示表格
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_delegete && [_delegete respondsToSelector:@selector(willShowView:)]) {
        [_delegete willShowView:self];
    }

    if (_delegete && [_delegete respondsToSelector:@selector(clickBeShowSelectView:)]&&_isOnlySelect) {
        [_delegete clickBeShowSelectView:self];
        return;
    }

    if (self.frame.size.height > _frame.size.height) {
        [self hiddenTableView];
        return;
    }
    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
    if (_parentView == nil) {
        _parentView = self.superview;
    }

    [_parentView addGestureRecognizer:_hiddenTapGesture];
    _superView = self.superview;

    if (self.superview != _parentView) {
        CGRect rect = [_superView convertRect:self.frame toView:_parentView];
        [_parentView addSubview:self];
        self.frame = rect;
    }

    _isSelectShow = YES;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.2];
    CGRect frame = self.frame;
    frame.size.height = self.frame.size.height +_backScrollView.frame.size.height +10;
    self.frame = frame;
    [UIView commitAnimations];
}

- (void)hiddenTableView { 
    [_parentView removeGestureRecognizer:_hiddenTapGesture];
    if (_superView != _parentView) {
        CGRect rect = [_parentView convertRect:self.frame toView:_superView];
        [_superView addSubview:self];
        self.frame = rect;
    }
    _isSelectShow = NO;
    [UIView animateWithDuration:.2 animations:^{
        self.frame = _frame;
    } completion:^(BOOL finished) {
        [_backScrollView setContentOffset:CGPointMake(0, 0)];
    }];
}

- (void)setFont:(float)fontSize {
    _selectLabel.font = [UIFont systemFontOfSize:fontSize];
}

@end
