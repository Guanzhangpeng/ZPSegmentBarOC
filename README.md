## ZPSegmentBarOC  该框架分为OC和Swfit两个版本:点击前往[Swift版本](https://github.com/Guanzhangpeng/ZPSegmentBar)

### 模仿今日头条或者是网易新闻 NavigationBar 效果,效果图如下:
 
![scroll.gif](http://upload-images.jianshu.io/upload_images/1154433-56621400635e2bf0.gif?imageMogr2/auto-orient/strip)                           
![scroll2.gif](http://upload-images.jianshu.io/upload_images/1154433-5e2d81b327126e04.gif?imageMogr2/auto-orient/strip)


 集成该框架步骤:
 
##### 1. 导入`ZPSegmentView`头文件: `#import "ZPSegmentView.h"`
 
##### 2. 实例化`ZPSegmentBarStyle`,并且传入我们需要的样式,例如:

  ```
  ZPSegmentBarStyle * style=[[ZPSegmentBarStyle alloc] init];
  style.isScrollEnabled=YES;//导航条是否可以滚动,默认YES;
  style.isShowCover=YES;//导航条是否显示遮盖效果,默认YES;
  style.coverViewMargin=6;//遮盖间距;
  style.isShowBottomLine=YES;//导航条下方是否显示BottomLine,默认YES;
  style.bottomLineColor=[UIColor orangeColor];//BottomLine 的颜色;
  style.isNeedScale=YES;//导航条是否有放大效果,默认YES;
  style.titleViewBG=[UIColor purpleColor];//导航条背景颜色,默认为紫色;
  ...
  ...
  ...  
  ```
  通过配置我们需要的样式可以轻松的实现` 遮盖 ` `文字缩放` ` 下划线` `文字颜色变化` 等样式.
  
##### 3. 实例化 `ZPSegmentView`,并且传入所需要的参数   


```
ZPSegmentView * segmentView=[[ZPSegmentView alloc]initWithFrame:frame];
[segmentView setupWithtitles:titles style:style childVcs:childVcs parentVc:self];
    
``` 
##### 4. 将创建好的 `ZPSegmentView`添加到当前`View`中即可
`[self.view addSubview:segmentView];`


## 注意:
如果是导航控制器,我们需要在集成的`View`中 设置 
`[self setAutomaticallyAdjustsScrollViewInsets:NO];`

## Installation

ZPSegmentBarOC is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZPSegmentBarOC', '~> 0.2.0'
```

## Author

[作者简书](http://www.jianshu.com/u/68bedf0c5c86)

zswangzp@163.com, zswangzp@163.com

## License

ZPSegmentBarOC is available under the MIT license. See the LICENSE file for more info.


