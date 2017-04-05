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

@end

@implementation ZPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    CGRect frame=CGRectMake(0, 0, self.view.width, self.view.height);
//    NSArray * titles=@[@"头条",@"娱乐",@"视频",@"段子",@"美女"];
    NSArray * titles = @[@"推荐",@"热点",@"直播",@"视频",@"阳光视频",@"社会热点",@"娱乐",@"科技",@"汽车"];
    NSMutableArray * childVcs=[NSMutableArray array];
    for (int i=0; i<titles.count; i++) {
        UIViewController * vc=[[UIViewController alloc]init];
        vc.view.backgroundColor=[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
        [childVcs addObject:vc];
    }
    ZPSegmentBarStyle * style=[[ZPSegmentBarStyle alloc] init];
    style.isScrollEnabled=YES;//默认YES
    style.isShowCover=YES;//默认YES;
    style.isShowBottomLine=YES;//默认YES;
    style.isNeedScale=YES;//默认YES;
    
    ZPSegmentView * segmentView=[[ZPSegmentView alloc]initWithFrame:frame];
    segmentView.backgroundColor=[UIColor purpleColor];
    [segmentView setupWithtitles:titles style:style childVcs:childVcs parentVc:self];
    
    [self.view addSubview:segmentView];
    
}
@end