//
//  ZPViewController.m
//  ZPSegmentBarOC
//
//  Created by zswangzp@163.com on 03/29/2017.
//  Copyright (c) 2017 zswangzp@163.com. All rights reserved.
//

#import "ZPViewController.h"
#import "ZPSegmentView.h"

@interface ZPViewController ()

@property (nonatomic, strong)ZPSegmentView *segmentView;

@property (nonatomic, strong)ZPSegmentBarStyle *style;
@end

@implementation ZPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    CGRect frame=CGRectMake(0, 0, self.view.width, self.view.height);
        NSArray * titles=@[@"头条",@"娱乐",@"直播",@"视频"];
//    NSArray * titles = @[@"推荐",@"热点",@"直播",@"视频",@"阳光视频",@"社会热点",@"娱乐",@"科技",@"汽车"];
    NSMutableArray * childVcs=[NSMutableArray array];
    for (int i=0; i<titles.count; i++) {
        UITableViewController * vc=[[UITableViewController alloc]init];
        vc.view.backgroundColor=[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
        [childVcs addObject:vc];
    }
    
    ZPSegmentBarStyle * style=[[ZPSegmentBarStyle alloc] init];
    style.isScrollEnabled=NO;//导航条是否可以滚动,默认YES;
//    style.isShowCover=YES;//导航条是否显示遮盖效果,默认YES;
//    style.coverViewMargin=6;//遮盖间距;
//    style.isShowBottomLine=YES;//导航条下方是否显示BottomLine,默认YES;
//    style.bottomLineColor=[UIColor orangeColor];//BottomLine 的颜色;
//    style.isNeedScale=YES;//导航条是否有放大效果,默认YES;
    
    style.isShowImage = YES;
    style.imageNames = @[@"message_sys",@"message_tz",@"message_sys",@"message_tz"];
    style.selectedImageNames = @[@"message_sys_h",@"message_tz_h",@"message_sys_h",@"message_tz_h"];
    style.imageSize = CGSizeMake(40.f, 40.f);
    style.segmentBarHeight = 70.f;
    style.isNeedScale = NO;
    style.titleHeight = 18.f;
    self.style = style;
    
    ZPSegmentView * segmentView=[[ZPSegmentView alloc]initWithFrame:frame];
    [segmentView setupWithtitles:titles style:style childVcs:childVcs parentVc:self];
    self.segmentView = segmentView;
    [self.view addSubview:segmentView];
    
    //3秒后自动滚动到第二个item上;
//    [self performSelector:@selector(demo1) withObject:NULL afterDelay:3];
    
}
-(void)demo1
{
    self.style.isDealFirstItem = YES;//用户是否手动设置滚动到某个item
    self.segmentView.contentView.isCustomScroll = YES;
    
    [self.segmentView.contentView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}
@end
