//
//  DefinePullDownSelectView.h
//  packageSegment
//
//  Created by mandy on 15/5/25.
//  Copyright (c) 2015年 mandy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DefinePullDownSelectView;

@protocol DefinePullDownSelectViewDelegate <NSObject>

@optional
/**
 *  非后台数据创建时执行的方法
 *
 *  @param selectView 下拉列表的实例
 */
- (void)willShowView:(DefinePullDownSelectView*)selectView;
/**
 *  非后台数据创建执行时协议方法
 *
 *  @param selectView 下拉列表的实例
 *  @param indexPath  选择行的位置
 */
- (void)selectView:(DefinePullDownSelectView*)selectView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  由后台数创建执行的协议方法
 *
 *  @param selectView 下拉列表的实例
 *  @param optionKey 选择项的guid
 */
- (void)selectView:(DefinePullDownSelectView *)selectView didSelectOptionKey:(NSString *)optionKey;

/**
 *  点击只触发事件，出发事件自己实现
 *
 *  @param pullView 下拉列表实例
 */
- (void)clickBeShowSelectView:(DefinePullDownSelectView *)pullView;
/**
 *  由后台数据创建时执行的协议方法
 *
 *  @param selectView 下拉列表实例
 *  @param dict       选择项的guid
 */
- (void)selectView:(DefinePullDownSelectView *)selectView didSelectOptionDictionary:(NSDictionary *)dict;

@end
@interface DefinePullDownSelectView : UIImageView<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    CGRect _frame;//原始frame
    NSArray *_dataArray;//表格显示的数据源
    UITableView *_menuTableView;//显示的表格
    UIScrollView *_backScrollView;
    UILabel *_selectLabel;//选择框选中的label
    NSInteger _selectRow;//当前选择的行
    BOOL _isRequestData;//是否是请求的数据
    UIView *_superView;//父视图
    UIView *_parentView;//可以点击收起下拉菜单的视图
    UITapGestureRecognizer *_hiddenTapGesture;//隐藏菜单手势
    UIImageView * _bgImageView;//下拉背景图片
    NSMutableArray *_locationArr;
}

@property (nonatomic,strong)NSArray *_dataArray;
@property (nonatomic,strong)UILabel *_selectLabel;
@property (nonatomic,assign)NSInteger _selectRow;
@property (nonatomic,assign)BOOL _isRequestData;
@property (nonatomic,strong)UIImageView *_bgImageView;
@property (nonatomic,strong)NSMutableArray *_locationArr;

@property (nonatomic,assign)BOOL _isSelectShow;
@property (nonatomic,assign)BOOL _isOnlySelect;//判断孰否只触发事件
@property (nonatomic,copy)NSString *_viewKey;

@property (nonatomic,weak)id<DefinePullDownSelectViewDelegate>delegete;

/**
 *  非后台数据初始化方法
 *
 *  @param frame     视图frame
 *  @param title     选择框默认显示的title
 *  @param dataArray 下拉菜单数据源
 *  @param aView     下拉框展开时展示下拉框的视图，只能为下拉框的视图或者父视图的父视图
 *
 *  @return 下拉选择框的实例
 */
- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title andDataArray:(NSArray*)dataArray inView:(UIView *)aView;

/**
 *  非后台数据初始化方法
 *
 *  @param frame     视图frame
 *  @param defaultSelectRow     选择框默认选择row
 *  @param dataArray 下拉菜单数据源
 *  @param aView     下拉框展开时展示下拉框的视图，只能为下拉框的视图或者父视图的父视图
 *
 *  @return 下拉选择框的实例
 */
- (id)initWithFrame:(CGRect)frame andDefaultSelectRow:(NSInteger)selectRow andDataArray:(NSArray *)dataArray inView:(UIView *)aView;

/**
 *  由请求数据创建下拉菜单
 *
 *  @param frame     由后台数据创建视图Frame
 *  @param dataArray 请求数据的下拉菜单数据源
 *  @param selectRow 默认选择行
 *  @param aView     下拉框展开时展示下拉框的视图，只能为下拉框的视图或者视图的父视图
 *
 *  @return 下拉选择框的实例
 */
- (id)initWithFrame:(CGRect)frame andRequestDataArray:(NSArray *)dataArray andDefaultSelectRow:(NSInteger)selectRow inView:(UIView *)aView;
/**
 *  重载下拉选择框的数据
 *
 *  @param reloadDataArray  新的数据源数组
 *  @param defaultSelectRow  新的默认选择行
 */
- (void)reloadDataArray:(NSArray *)reloadDataArray andDefaultSelectRow:(NSInteger)defaultSelectRow;
/**
 *  隐藏下拉菜单
 */
- (void)hiddenTableView;

- (void)setFont:(float)fontSize;

@end
