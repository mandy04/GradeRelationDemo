//
//  ViewController.m
//  gradeDemo
//
//  Created by llbt on 15/12/1.
//  Copyright © 2015年 llbt. All rights reserved.
//

#import "ViewController.h"
#import "GradeViewModel.h"
#import "GradeModule.h"
#import "DefinePullDownSelectView.h"

#define kkScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<DefinePullDownSelectViewDelegate>
{
    GradeModule *module;//联级模块
    GradeViewModel *viewModel;//联级ViewModel
    NSArray *institutionGrade;//机构等级
}

@property (nonatomic,strong)UIView *gradeBgView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    module = [[GradeModule alloc]init];
    viewModel = [[GradeViewModel alloc]init];
    institutionGrade = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七"];

    [self loadGradeDataView];
}
/**
 * 层级背景视图
 *
 *  @return _gradeBgView
 */
-(UIView *)gradeBgView
{
    if (!_gradeBgView) {
        _gradeBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kkScreenWidth, 0)];
        _gradeBgView.backgroundColor = [UIColor clearColor];
    }
    return _gradeBgView;
}

//获取申请层级字段
- (void)loadGradeDataView {
    
    //显示一级机构时id为空，二级以后的机构都要根据下发的id作为参数上送
    if (viewModel.selectIndexs.count == 0)
    {
        NSDictionary *oneInstitudeDic = @{@"id":@""};
        module.institudeDic = oneInstitudeDic;
        [module getQueryCustomFieldChildsByPidOnSuccess:^(NSArray *model)
         {
             NSMutableArray *arr = [NSMutableArray arrayWithArray:model];
             [viewModel.dataDic setValue:arr forKey:[NSString stringWithFormat:@"%2lu",(unsigned long)viewModel.selectIndexs.count]];
             [viewModel.selectIndexs addObject:@"-1"];
             
             [self loadCustomGrade];
         } onFailure:^(NSString *string)
         {
             viewModel.dataDic = [[NSMutableDictionary alloc]initWithCapacity:0];
             viewModel.selectIndexs = [[NSMutableArray alloc]initWithCapacity:0];
             [self loadCustomGrade];
         }];
    }
}

/**
 *  加载层级视图
 */
- (void)loadCustomGrade
{
    [self.view addSubview:self.gradeBgView];
    [[self.gradeBgView subviews] valueForKeyPath:@"removeFromSuperview"];
    
    int index = 0;
    for (int i = 0; i < viewModel.selectIndexs.count; i++)
    {
        index = i;
        NSString *idstr = viewModel.selectIndexs[i];
        NSArray *arr = viewModel.dataDic[[NSString stringWithFormat:@"%2d",i]];
        if (arr)
        {
            NSString * name = @"--------请选择--------";
            NSArray *tempArr = [arr valueForKeyPath:@"fieldValue"];
            if (![idstr isEqualToString:@"-1"]) {
                NSDictionary *dicL = arr[[idstr intValue]];
                name = dicL[@"fieldValue"];
            }
            
            UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, i * 34  + 34  -  25 - 5, 78, 25)];
            oneLabel.text = [institutionGrade[i] stringByAppendingString:@"级机构:"];
            oneLabel.font = [UIFont systemFontOfSize:14.0f];
            oneLabel.textColor = [UIColor blackColor];
            [self.gradeBgView addSubview:oneLabel];

            DefinePullDownSelectView *gradePullDownList = [[DefinePullDownSelectView alloc]initWithFrame:CGRectMake(110, i * 34  + 34  - 25 - 5, kkScreenWidth-150, 25) andTitle:name andDataArray:tempArr inView:self.view];
            gradePullDownList.delegete = self;
            gradePullDownList.tag = i + 300;
            [self.gradeBgView addSubview:gradePullDownList];
        }
    }
    CGRect frame =  self.gradeBgView.frame;
    frame.size.height = index * 35 + 35;
    self.gradeBgView.frame = frame;
}

/**
 *  实现下拉选择代理方法
 *
 *  @param selectView
 *  @param indexPath
 */
- (void)selectView:(DefinePullDownSelectView*)selectView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger colum = selectView.tag - 300;
    NSInteger rowl = indexPath.row;
    [viewModel.selectIndexs removeObjectsInRange:NSMakeRange(colum, viewModel.selectIndexs.count - colum)];
    [viewModel.selectIndexs addObject:[NSString stringWithFormat:@"%ld",(long)rowl]];
    
    NSString *selectedID = viewModel.selectedId;
    if (selectedID) {
        NSMutableString *reqId = [NSMutableString stringWithCapacity:0];
        NSArray *selectedIdList = [viewModel selectedIdList];
        for (NSString *str in selectedIdList) {
            [reqId appendString:str];
        }
        
        NSDictionary *oneInstitudeDic = @{@"id":reqId};
        module.institudeDic = oneInstitudeDic;
        [module getQueryCustomFieldChildsByPidOnSuccess:^(NSArray *model)
         {
             NSMutableArray *arr = [NSMutableArray arrayWithArray:model];
             [viewModel.dataDic setValue:arr forKey:[NSString stringWithFormat:@"%2lu",(unsigned long)viewModel.selectIndexs.count]];
             [viewModel.selectIndexs addObject:@"-1"];
             if (selectedIdList.count < institutionGrade.count) {
                 [self loadCustomGrade];
             }
         } onFailure:^(NSString *string)
         {
            [self loadCustomGrade];
         }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
