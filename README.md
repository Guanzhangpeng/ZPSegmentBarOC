# ZPSegmentBarOC
##该框架分为OC和Swfit两个版本:点击前往[Swift版本](https://github.com/Guanzhangpeng/ZPSegmentBar)
### 模仿今日头条或者是网易新闻 NavigationBar 效果,效果图如下:
 
![scroll.gif](http://upload-images.jianshu.io/upload_images/1154433-56621400635e2bf0.gif?imageMogr2/auto-orient/strip)                           
![scroll2.gif](http://upload-images.jianshu.io/upload_images/1154433-5e2d81b327126e04.gif?imageMogr2/auto-orient/strip)


 集成该框架非常的方便,我们只需要调用 
 
 ```
ZPSegmentView * segmentView=[[ZPSegmentView alloc]initWithFrame:frame];
[segmentView setupWithtitles:titles style:style childVcs:childVcs parentVc:self];
[self.view addSubview:segmentView];
 ``` 
 然后传入我们期望的style效果即可,扩展性非常强,例如:
 
```
ZPSegmentBarStyle * style=[[ZPSegmentBarStyle alloc] init];
style.isScrollEnabled=YES;//导航条是否可以滚动,默认YES;
style.isShowCover=YES;//导航条是否显示遮盖效果,默认YES;
style.coverViewMargin=6;//遮盖间距;
style.isShowBottomLine=YES;//导航条下方是否显示BottomLine,默认YES;
style.bottomLineColor=[UIColor orangeColor];//BottomLine 的颜色;
style.isNeedScale=YES;//导航条是否有放大效果,默认YES;
...
...
...
```


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

ZPSegmentBarOC is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZPSegmentBarOC"
```

## Author

[作者简书](http://www.jianshu.com/u/68bedf0c5c86)

zswangzp@163.com, zswangzp@163.com

## License

ZPSegmentBarOC is available under the MIT license. See the LICENSE file for more info.


