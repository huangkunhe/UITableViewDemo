#[UITableView滚动条不消失](https://www.jianshu.com/p/2de9a4725620)

![enter image description here](http://wx4.sinaimg.cn/mw690/66d4d14cgy1ff95krvf0uj20qo0hsq67.jpg)
-------------------

## 前言


最近刚好遇到这么一个需求，当列表数据超过列表高度的时候，需要显示滚动条。
目前，UItableview无法一直显示滚动条，只有当用户往下拉会出现滚动条，后面会自动消失。无法满足用户需求。
网上搜索一番，解决方案主要有两种，第一，自定义view，监听滚动，添加自定义滚动条；第二，重写UIImageView分类，重新setAlpha方法。第一种，确定可以实现，但是看着和操作不如自带的自然顺畅，放弃；第二种，会出现其他图片显示不出来。百思不得其解，果断放弃。
##实现
灵光一现，从第二种方法，知道UIScrollView 的 滚动条(ScrollBar Indicators)，就是默认右侧的 darkgray 条，当你滚动一个 UIScrollView 的时间，这个滚动条就会显示，并且显示和隐藏都是淡入和淡出的。 这是，你或许就能猜到是什么了：UIImageView. 滚动条就是一个UIImageView，那个滚动条就是一个图片而已。而滚动条的消失、隐藏淡入淡出，都是设置的 UIImageView的 -(void) setAlpha 方法。但是分类会影响所有的UIImageView类，那就单独获取UITableView的UIImageView进行二次改造。这种做法，其实很常见，例如改变searchbar的相关属性，uilaterview的标题属性等等。二话不说，看下面代码。
```
- (void)layoutSubviews{

[super layoutSubviews];
[self.subviews enumerateObjectsUsingBlock:^( id obj, NSUInteger idx, BOOL * _Nonnull stop) {
if ([obj isKindOfClass:[UIImageView class]]) {
UIImageView * imageView = [[UIImageView alloc] init];
imageView = obj;
imageView.alpha = 1 ;
}
}];
UIView * view = [self.subviews lastObject];
if (view.top < 0) {
view.top = 0;
}

}
```

1、建立一个UItableview的分类，重写layoutSubviews
2、遍历查询出UIImageView，设置透明度为1
3、设置UIImageView的x为0(让滚动条显示)
以上设置这样就可以永远显示自带滚动条，你可以根据需求设置什么时候显示，什么时候不显示。具体还是看需求，这里提示这样一种解决方案。
##源码
上述是主要流程，完整的源码可以通过以下方式获取

https://github.com/huangkunhe/UITableViewDemo

##小结
谢谢以下博主提供的思路
https://www.cnblogs.com/xunziji/p/3248850.html
https://www.jianshu.com/p/85ca51a22609
