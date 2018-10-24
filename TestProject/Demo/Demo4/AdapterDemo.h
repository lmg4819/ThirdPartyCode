//
//  AdapterDemo.h
//  TestProject
//
//  Created by lmg on 2018/8/22.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdapterDemo : UIViewController

@end
/*
 设计模式的六大原则
 开闭原则是目标，里氏替换原则是基础，依赖倒转原则是手段
 
 
 1.开闭原则（open close principle）最终目的
 对扩展开放，对修改封闭，我们使用接口和抽象类，来达到这样的目的，抽象化是开闭原则的关键
 
 
 2.里氏代换原则
 是对开闭原则的补充，任何基类可以出现的地方，子类一定可以出现，实现开闭原则的关键就是抽象化，而基类和抽象类
 的继承关系就是抽象化的具体实现。所以里氏代还原则是对实现抽象化的具体步骤的规范。因此在程序中尽量使用基类类型
 来对对象进行定义，而在运行时再确定其子类类型，用子类对象来代替父类对象。
 
 继承
 
 
 3.依赖倒转原则
 这个原则是开闭原则的基础。具体内容：针对接口编程，而不是针对实现编程，依赖于抽象而不是依赖于具体。在不修改源代码
 的情况下来扩展系统的功能，满足开闭原则的要求。
 
 基类，抽象类，CAAnimation和NSOperation
 
 4.接口隔离原则
 这个原则的意思是：使用多个隔离的接口，比使用单个接口要好。降低类之间的耦合度。设计模式就是从大型软件架构出发，
 便于升级和维护的软件设计思想，它强调降低依赖，降低耦合。
 
 可选协议和必须实现的协议就是接口隔离原则在具体实现
 
 
 
 5.迪米特原则（最少知道原则）
 最少知道原则是指：一个实体应当尽量少地与其他实体之间发生相互作用，使得系统功能模块相对独立。
 
 
 6.合成复用原则
 一个类只负责一个功能领域中的相应职责
 
 7.单一职责原则
 一个类或者模块应该有且只有一个改变的原因，目的是为了实现高内聚低耦合
 
 */
/*
 
 简单工厂模式：不是23种设计模式的一种，专门定义一个类来负责其他类的创建，被创建的实例通常都具有共同的父类
 实例：NSNumber
 工厂模式：定义一个用于创建对象的接口，让子类来决定实例化哪一个类，使一个类的实例化延迟到其子类
 
 抽象工厂模式：提供一个创建一系列相关或者相互依赖对象的接口，而无需指定具体的类
 
 当产品只有一个的时候，抽象工厂模式即变成工厂模式，当工厂模式的产品变为多个时，工厂模式即变成抽象工厂模式。一般说，产品
 种类单一，适合用工厂模式；如果有多个种类，通过抽象工厂模式来创建是很合适的。
 
 单例模式：
 
 23中设计模式：
 创建型模式，五种：工厂模式，抽象工厂模式，单例模式，建造者模式，原型模式
 
 结构型模式，七种：适配器模式，代理模式，组合模式，装饰器模式，亨元模式，外观模式，桥接模式，
 
 行为型模式，十一种：观察者模式，策略模式，中介者模式，模板方法模式，迭代子模式，责任链模式，命令模式，备忘录模式
                 状态模式，访问者模式，解释器模式
 
 
 
 
 
 
 */
