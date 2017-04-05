//
//  ZPSegmentBarContent.h
//  ZPSegmentBarOC
//
//  Created by 管章鹏 on 2017/3/31.
//  Copyright © 2017年 zswangzp@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZPSegmentBarContent;

@protocol ZPSegmentBarContentDelegate <NSObject>

-(void)segmentBarContent:(ZPSegmentBarContent * )segmentBarContent targetIndex:(NSInteger )targetIndex;

-(void)segmentBarContent:(ZPSegmentBarContent * )segmentBarContent didSelectedIndex:(NSInteger )selectedIndex fromIndex:(NSInteger )fromIndex process:(CGFloat)process;

@end

@interface ZPSegmentBarContent : UIView 


-(void)setupWithChildVcs:(NSArray <UIViewController *> *)childVcs parentVc:(UIViewController *)parentVc;

@property(nonatomic,weak) id<ZPSegmentBarContentDelegate> delegate;

@end
