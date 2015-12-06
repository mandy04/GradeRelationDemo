# GradeRelationDemo
# 首先需导入自定义下拉列表控件DefinePullDownSelectView.h
# 采用MVVM模式
# 遵守协议，设置代理 调用
DefinePullDownSelectView *gg = [[DefinePullDownSelectView alloc]initWithFrame:frame andTitle:name andDataArray:tempArr inView:self.view];
            gg.delegete = self;
            gg.tag = 300+i;
            [self.bgView addSubview:gg];
            
