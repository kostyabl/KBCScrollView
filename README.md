# KBCScrollView
UIView slider / carousel in UIScrollView
# Demo
![alt tag](https://raw.githubusercontent.com/kostyabl/KBCScrollView/master/KBCScrollView480.gif)
# Usage
Just add <code>KBCScrollView.h</code> and <code>KBCScrollView.m</code> files to your project.<br>
Add UIScrollView view on ViewController in storyborad<Br>
Next, setup KBCScrollView by adding few line of code:<br>
Array with yours UIViews
```objc
    NSMutableArray* arrWithUIViews = ...
```  
Assign your array to KBCScrollView.views
```objc
    self.scrollView.views = arrWithUIViews;
```  
It's all for minimal init.
# Delegate methods
Setup<br>
1. Your object should to conform the a protocol KBCScrollViewDelegate <br>
2. Set delegate, example. : <code> self.scrollView.kbcScrollViewdelegate = self; </code><br>
Current page did change.<br>
```objc
-(void)currentPageDidChage:(NSUInteger)pageNumber;
```  
View did tapped
```objc
-(void)didTappedToView:(UIView*)view onPage:(NSUInteger)pageNumber;
```  


