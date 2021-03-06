//
//  AppDelegate.h
//  TestProject
//
//  Created by lmg on 2018/7/31.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@end

/*
 OC可执行程序是由代码，初始化和未初始化的程序数据，链接信息，重定向信息，局部数据和动态数据构成的。程序数据包括以静态方式声明的变量和程序常量。
 可执行代码，程序数据以及链接和重定向信息会以静态方式被分配内存，并在程序的声明周期中一直存在。
 
 
 
 
 */








/*
 视图层次关系
 
1. containerView：optional
默认是frontWindow
 
2.controlView：UIControl
 
 
3.self：SVProgressHUD
 
 
4.1 hudView:UIVisualEffectView(上层)
4.2 backgroundView:UIView(最下面)
 
 
5.1  imageView                     --->hudView(superView):UIImageView
5.2  statusLabel                   --->hudView(superView):UILabel
5.3  indefiniteAnimatedView        --->hudView(superView):SVIndefiniteAnimatedView/UIActivityIndicatorView
5.4  ringView                      --->hudView(superView):SVProgressAnimatedView
5.5  backgroundRingView            --->hudView(superView):SVProgressAnimatedView
 
 
 
 
 licenceVC.vType = 5;

 
 ViewModel存在的目的在于抽离ViewController中展示业务逻辑,而不是替代ViewController,既然不负责视图操作逻辑，ViewModel中就不应该存在任何View对象，更不应该存在Push/Present等视图跳转逻辑。

 controller在MVVM中，一方面负责View和ViewModel之间的绑定，另一方面也负责常规的UI逻辑
 处理
 

 
 */
