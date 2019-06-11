//
//  ZPSegmentBar.m
//  ZPSegmentBarOC
//
//  Created by 管章鹏 on 2017/3/30.
//  Copyright © 2017年 zswangzp@163.com. All rights reserved.
//


#import "ZPSegmentBarTitle.h"
#import "UIView+ZPSegmentBar.h"
#import "ZPSegmentBarStyle.h"
#import "ZPSegmentBarContent.h"

@interface ZPSegmentBarTitle()<ZPSegmentBarContentDelegate>
{
    NSInteger _currentIndex;
    
}
@property(nonatomic,strong) UIScrollView * scrollView;
@property(nonatomic,strong) ZPSegmentBarStyle * style;
@property(nonatomic,strong) NSArray<NSString *>* titles;
@property(nonatomic,strong) NSMutableArray<UILabel *> * titleLbls;
@property(nonatomic,strong) NSMutableArray<UIImageView *> * titleIcons;
@property(nonatomic,strong) NSMutableArray<UIView *> * titleViews;
@property(nonatomic,strong) NSMutableArray<UIView *> * dotViews;

@property(nonatomic,strong) NSArray * normalColorRGB;
@property(nonatomic,strong) NSArray * selectedColorRGB;
@property(nonatomic,strong) NSMutableArray * deltaColorRGB;



/**
 底部指示器
 */
@property(nonatomic,strong) UIView * bottomLine;


/**
 遮盖
 */
@property(nonatomic,strong) UIView * coverView;

@end
@implementation ZPSegmentBarTitle

-(void)updateDotViewState:(NSNotification *)noti{
   NSInteger index= [noti.userInfo[@"index"] integerValue];
    BOOL state = [noti.userInfo[@"state"] boolValue];
    if (self.dotViews.count > 0) {
        
        self.dotViews[index].hidden = !state;
    }
}
-(void)setupWithTitles:(NSArray<NSString *> *)titles style:(ZPSegmentBarStyle *)style
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDotViewState:) name:UPDATEDOTVIEWSTATE object:nil];
    
    self.titles=titles;
    self.style=style;
    _currentIndex = 0 ;
    
    //1.0 初始化UIScrollView
    [self addSubview:self.scrollView];
    
    //2.0 初始化UILabel并且布局
        [self setupTitleAndImage];
        if (self.style.isShowBottomLine) {
            [self setupBottomLine];
        }
        
        //4.0 添加CoverView并且布局
        if (self.style.isShowCover) {
            [self setupCoverView];
        }

}


#pragma mark 初始化TitleLabel和UIimageView
- (void) setupTitleAndImage{
    for (int i=0;i<self.titles.count;i++)
    {
        UIView *titleView = [[UIView alloc] init];
//        titleView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
        titleView.tag=i;
        //初始化title
        UILabel * lblTitle = [[UILabel alloc] init];
        lblTitle.text=self.titles[i];
        lblTitle.textAlignment=NSTextAlignmentCenter;
        lblTitle.font=self.style.titleFont;
        lblTitle.textColor = i==0? self.style.selecteColor :self.style.normalColor;
        lblTitle.userInteractionEnabled=YES;
        
        //添加点击手势;
        UITapGestureRecognizer * tapGes =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleViewClick:)];
        [titleView addGestureRecognizer:tapGes];
       
     
        [titleView addSubview:lblTitle];
        [self.titleViews addObject:titleView];
        [self.titleLbls addObject:lblTitle];
        [self.scrollView addSubview:titleView];
        
        
        if (self.style.isShowImage) {
            //初始化icon
            UIImageView *iconView = [[UIImageView alloc] init];
            iconView.image = i == 0?   [UIImage imageNamed:self.style.selectedImageNames[i]]:[UIImage imageNamed:self.style.imageNames[i]];
           
            [titleView addSubview:iconView];
            [self.titleIcons addObject:iconView];
        }
        if (self.style.isShowDot) {
            UIView *dotView = [[UIView alloc] init];
            dotView.backgroundColor = [UIColor redColor];
            dotView.layer.cornerRadius = 6.f;
            [titleView addSubview:dotView];
            [self.dotViews addObject:dotView];
        }
    }
    
    //如果不能够滚动计算文字之间的间距;
    CGFloat calculteMargin = 0 ;
    CGFloat titleLabelX = 0 ;
    CGFloat titleLabelY = 0 ;
    CGFloat titleLabelW = 0 ;
    NSMutableDictionary * attribute=[NSMutableDictionary dictionary];
    attribute[NSFontAttributeName]=self.style.titleFont;
    
    if (!self.style.isScrollEnabled)
    {
        CGFloat totalWidth = 0 ;
        for(UILabel * title in self.titleLbls)
        {
            if(self.style.isShowDot){
                  titleLabelW= [title.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.style.titleHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width;
                if (self.style.isShowImage) {
                    totalWidth += titleLabelW;
                }else{
                    titleLabelW += 12;
                    totalWidth += titleLabelW;
                }
            }else{
                titleLabelW= [title.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.style.titleHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width;
                totalWidth += titleLabelW;
            }
            
        }
        calculteMargin = (self.width - totalWidth)/self.titleLbls.count;
        
    }
    
    //布局titleLabel的frame
    for (int index=0; index<self.titleLbls.count; index++) {
        
        UILabel * title=self.titleLbls[index];
        UIView *titleView = self.titleViews[index];
        
        titleLabelW= [title.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.style.titleHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width;
        
       
        //标题能够滚动
        if(self.style.isScrollEnabled)
        {
            titleLabelX = index==0 ? self.style.titleMargin * 0.5 : CGRectGetMaxX(self.titleViews[index-1].frame)+ self.style.titleMargin;
        }
        else
        {
            titleLabelX = index==0 ? calculteMargin * 0.5 : CGRectGetMaxX(self.titleViews[index-1].frame)+calculteMargin;
        }
        
        

        if (self.style.isShowDot) {
            if (self.style.isShowImage) {
                UIImageView *iconView = self.titleIcons[index];
                 UIView *dotView = self.dotViews[index];
                 titleLabelW = titleLabelW > self.style.imageSize.width + 24.f ? titleLabelW : self.style.imageSize.width + 24.f;
                titleView.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, self.style.segmentBarHeight);
                iconView.frame = CGRectMake(0.f, 5.f, self.style.imageSize.width, self.style.imageSize.height);
                dotView.frame = CGRectMake(self.style.imageSize.width + 12.f, 5.f, 12.f, 12.f);
                title.frame = CGRectMake(0.f, CGRectGetMaxY(iconView.frame) + self.style.titleImageSpacing, titleLabelW, self.style.titleHeight);
                 iconView.centerX = title.centerX;
            }else{
                UIView *dotView = self.dotViews[index];
                titleView.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW+12, self.style.segmentBarHeight);
                 title.frame = CGRectMake(0.f, titleLabelY, titleLabelW , self.style.titleHeight);
                 dotView.frame = CGRectMake( CGRectGetMaxX(title.frame), 5.f, 12.f, 12.f);
            }
            
        }else{
            if (self.style.isShowImage) {
                UIImageView *iconView = self.titleIcons[index];
               
                titleLabelW = titleLabelW > self.style.imageSize.width + 24.f ? titleLabelW : self.style.imageSize.width + 24.f;
                titleView.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, self.style.segmentBarHeight);
                iconView.frame = CGRectMake(0.f, 5.f, self.style.imageSize.width, self.style.imageSize.height);
               
                title.frame = CGRectMake(0.f, CGRectGetMaxY(iconView.frame) + self.style.titleImageSpacing, titleLabelW, self.style.titleHeight);
                iconView.centerX = title.centerX;
            }else{
                titleView.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, self.style.segmentBarHeight);
                title.frame = CGRectMake(0.f, titleLabelY, titleLabelW , self.style.titleHeight);
            }
        }
    }
    
    //如果titleView可以滚动设置ContentSize范围;
    if (self.style.isScrollEnabled) {
        self.scrollView.contentSize=CGSizeMake(CGRectGetMaxX(self.titleViews.lastObject.frame)+self.style.titleMargin*0.5, 0);
    }
    
    
    //让第一个按钮处于选中状态;
    if (self.style.isNeedScale) {
        self.titleLbls.firstObject.transform= CGAffineTransformMakeScale(self.style.maxScale, self.style.maxScale);
    }
    
    
    //决定是否显示小红点
    if(self.style.isShowDot){
        for (int i= 0; i<self.style.dotStates.count; i++) {
            NSNumber *flag = self.style.dotStates[i];
            UIView *dotView = self.dotViews[i];
            dotView.hidden = ![flag boolValue];
        }
    }
}
#pragma mark 初始化BottomLine
-(void)setupBottomLine
{
    [self.scrollView addSubview:self.bottomLine];
    self.bottomLine.frame=self.titleViews.firstObject.frame;
    if (self.style.isShowDot && !self.style.isShowImage) {
        self.bottomLine.width -= 12;
    }
    self.bottomLine.height=self.style.bottomLineHeight;
    self.bottomLine.y=self.height-self.style.bottomLineHeight;
}

#pragma mark 初始化CoverView
-(void)setupCoverView
{
    [self.scrollView insertSubview:self.coverView atIndex:0];
    CGFloat coverViewX = self.titleViews.firstObject.x - self.style.coverViewMargin;
    CGFloat coverViewY = (self.style.titleHeight - self.style.coverViewHeight) * 0.5;
    CGFloat coverViewH = self.style.coverViewHeight;
    CGFloat coverViewW = self.titleViews.firstObject.width + self.style.coverViewMargin * 2;

    self.coverView.frame= CGRectMake(coverViewX, coverViewY, coverViewW, coverViewH);
}

- (void)titleViewClick:(UITapGestureRecognizer  *)tapGes{
    UIView * targetView =tapGes.view ;
    UILabel *targetLabel = targetView.subviews[0];
    
   
    
    //如果是之前点击的按钮则不再继续执行;
    if (_currentIndex == targetView.tag) {
        return;
    }
    
    //获取UILabel
    UILabel * sourceLabel = self.titleLbls[_currentIndex];
    sourceLabel.textColor = self.style.normalColor;
    targetLabel.textColor = self.style.selecteColor;
    
    
    if (self.style.isShowBottomLine) {
        //调整bottomLine的位置;
        [UIView animateWithDuration:0.25 animations:^{
           
            self.bottomLine.width=targetLabel.width;
            self.bottomLine.x=targetView.x;
        }];
    }
    
    
    
    //调整选中titleLabel的尺寸;
    if(self.style.isNeedScale)
    {
        [UIView animateWithDuration:0.25 animations:^{
            sourceLabel.transform=CGAffineTransformIdentity;
            targetLabel.transform = CGAffineTransformMakeScale(self.style.maxScale, self.style.maxScale);
            
        }];
    }
    
    //调整CoverView的位置;
    if (self.style.isShowCover) {
        [UIView animateWithDuration:0.25 animations:^{
            
            self.coverView.x = targetView.x - self.style.coverViewMargin;
            self.coverView.width = targetView.width + self.style.coverViewMargin * 2;
            
        }];
    }
    if (self.style.isShowImage){
         UIImageView *targetImageView = targetView.subviews[1];
        UIImageView *sourceImageView = self.titleIcons[_currentIndex];
        sourceImageView.image = [UIImage imageNamed:self.style.imageNames[_currentIndex]];
        targetImageView.image = [UIImage imageNamed:self.style.selectedImageNames[targetView.tag]];

    }

    //执行代理方法
    if ([self.delegate respondsToSelector:@selector(segmentBarTitle:fromIndex:toIndex:)]) {
        [self.delegate segmentBarTitle:self fromIndex:_currentIndex toIndex:targetView.tag];
    }
    
    _currentIndex = targetView.tag;
    //调整titleLabel的位置;
    if (self.style.isScrollEnabled) {
        [self adjustLabelPosition];
    }
}
#pragma mark 调整titleLabel的位置
-(void)adjustLabelPosition
{
    //如果标题不能滚动,则不再继续;
    if (!self.style.isScrollEnabled) {
        return;
    }
    
    CGFloat offsetX;
    if (self.style.isShowImage) {
      
        UIView * targetView = self.titleViews[_currentIndex];
        offsetX=targetView.centerX - self.scrollView.width * 0.5;
       
    }else{
       UIView * targetView = self.titleViews[_currentIndex];
        offsetX=targetView.centerX - self.scrollView.width * 0.5;
    }
   
    if (offsetX < 0) {
        offsetX=0;
    }
    CGFloat maxOffsetX =self.scrollView.contentSize.width - self.scrollView.width;
    
    if (offsetX >maxOffsetX ) {
        offsetX=maxOffsetX;
    }
    
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
   
}

#pragma mark -- ZPSegmentBarContentDelegate
-(void)segmentBarContent:(ZPSegmentBarContent *)segmentBarContent targetIndex:(NSInteger)targetIndex
{
    _currentIndex=targetIndex;
    
    [self adjustLabelPosition];
    
    
}

-(void)segmentBarContent:(ZPSegmentBarContent *)segmentBarContent didSelectedIndex:(NSInteger)selectedIndex fromIndex:(NSInteger)fromIndex process:(CGFloat)process
{

    //1.0 获取UILabel
    UIView *sourceView = self.titleViews[fromIndex];
     UIView *targetView = self.titleViews[selectedIndex];
    UILabel * sourceLabel = self.titleLbls[fromIndex];
    UILabel * targetLabel = self.titleLbls[selectedIndex];
    
    _currentIndex=selectedIndex;
    
    //让第一个选项 是正常的颜色
    if(self.style.isDealFirstItem && selectedIndex != 0 && fromIndex != 0)
    {
        UILabel *firstLabel = self.titleLbls[0];
        firstLabel.textColor = self.style.normalColor;
        firstLabel.transform = CGAffineTransformMakeScale(1.0 , 1.0);
        
    }

    if (self.style.isShowImage) {
        if (process == 1.0f) {
            if(fromIndex == selectedIndex){
                fromIndex --;
            }
            UILabel * sourceLabel = self.titleLbls[fromIndex];
            UILabel * targetLabel = self.titleLbls[selectedIndex];
            
            UIImageView * sourceImageView = self.titleIcons[fromIndex];
            UIImageView * targetImageView = self.titleIcons[selectedIndex];
            
            sourceImageView.image = [UIImage imageNamed:self.style.imageNames[fromIndex]];
            targetImageView.image =[UIImage imageNamed:self.style.selectedImageNames[selectedIndex]];
            
            sourceLabel.textColor = self.style.normalColor;
            targetLabel.textColor = self.style.selecteColor;
        }
      
    }else{
        //2.0 颜色渐变
        sourceLabel.textColor= [UIColor colorWithRed:[self.selectedColorRGB[0] floatValue]-[self.deltaColorRGB[0] floatValue] * process green:[self.selectedColorRGB[1] floatValue]-[self.deltaColorRGB[1] floatValue] * process blue:[self.selectedColorRGB[2] floatValue]-[self.deltaColorRGB[2] floatValue] * process alpha:1.0];
        
        targetLabel.textColor = [UIColor colorWithRed:[self.normalColorRGB[0] floatValue]+[self.deltaColorRGB[0] floatValue] * process green:[self.normalColorRGB[1] floatValue]+[self.deltaColorRGB[1] floatValue] * process blue:[self.normalColorRGB[2] floatValue]+[self.deltaColorRGB[2] floatValue] * process alpha:1.0];
    }
   
    
    //3.0 文字缩放
    if(self.style.isNeedScale )
    {
        CGFloat deltaScale = self.style.maxScale - 1.0 ;
        
        [UIView animateWithDuration:0.25 animations:^{
            sourceLabel.transform=CGAffineTransformMakeScale(self.style.maxScale - deltaScale * process, self.style.maxScale - deltaScale * process);
            targetLabel.transform = CGAffineTransformMakeScale(1.0 + deltaScale * process, 1.0 + deltaScale * process);
        }];
    }
    CGFloat deltaX = targetView.x - sourceView.x;
    CGFloat deltaWidth = targetView.width - sourceView.width;
    
    //4.0 改变bottomLine的位置;
    if (self.style.isShowBottomLine)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomLine.width=sourceLabel.width + deltaWidth * process;
            self.bottomLine.x= sourceView.x + deltaX * process;
            
        }];
    }
    
    //5.0 遮盖效果
    if(self.style.isShowCover)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.coverView.x=sourceView.x+deltaX * process -self.style.coverViewMargin;
            self.coverView.width = sourceLabel.width +deltaWidth * process+ self.style.coverViewMargin * 2;
        }];
    }
    
}



#pragma mark 数据懒加载

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        
        scrollView.showsVerticalScrollIndicator=NO;
        scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView=scrollView;
    }
    return _scrollView;
}
-(NSMutableArray<UILabel *> *)titleLbls{
    if (!_titleLbls) {
        _titleLbls=[NSMutableArray array];
    }
    return _titleLbls;
}
-(NSMutableArray<UIImageView *> *)titleIcons{
    if (!_titleIcons) {
        _titleIcons=[NSMutableArray array];
    }
    return _titleIcons;
}
-(NSMutableArray<UIView *> *)titleViews{
    if (!_titleViews) {
        _titleViews = [NSMutableArray array];
    }
    return _titleViews;
}
-(NSMutableArray<UIView *> *)dotViews{
    if (!_dotViews) {
        _dotViews = [NSMutableArray array];
    }
    return _dotViews;
}
-(UIView *)bottomLine
{
    if (!_bottomLine) {

        UIView * bottomLine=[[UIView alloc]init];
        bottomLine.backgroundColor=self.style.bottomLineColor;
        _bottomLine=bottomLine;
    }
    return _bottomLine;
}
-(UIView *)coverView
{
    if (!_coverView) {
        
        _coverView=[[UIView alloc]init];
        _coverView.backgroundColor=self.style.coverViewColor;
        _coverView.alpha=self.style.coverViewAlpha;
        _coverView.layer.cornerRadius=self.style.coverViewRadius;
        _coverView.layer.masksToBounds=YES;
        
        
    }
    return  _coverView;
}

#pragma mark -- 颜色相关方法
-(NSArray *)normalColorRGB{
    if (!_normalColorRGB) {
        _normalColorRGB=[NSArray array];
        _normalColorRGB = [self getRGBWithColor:self.style.normalColor];
    }
    return _normalColorRGB;
}
-(NSArray *)selectedColorRGB{
    if (!_selectedColorRGB) {
        _selectedColorRGB=[NSArray array];
        _selectedColorRGB=[self getRGBWithColor:self.style.selecteColor];
    }
    return _selectedColorRGB;
}
-(NSMutableArray *)deltaColorRGB{
    if (!_deltaColorRGB) {
        _deltaColorRGB=[NSMutableArray array];
        
        _deltaColorRGB[0]=@([self.selectedColorRGB[0] floatValue] - [self.normalColorRGB[0] floatValue]);
        _deltaColorRGB[1]=@([self.selectedColorRGB[1] floatValue] - [self.normalColorRGB[1] floatValue]);
        _deltaColorRGB[2]=@([self.selectedColorRGB[2] floatValue] - [self.normalColorRGB[2] floatValue]);
    }
    return _deltaColorRGB;
}

- (NSArray *)getRGBWithColor:(UIColor *)color
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
