# testHookzz
iOS使用HookZz框架修改“This war of mine”游戏的逻辑，使其进入上帝模式


## 功能介绍

本项目主要目的是学习使用[HookZz](https://github.com/jmpews/HookZz)框架做iOS逆向

本项目中使用的游戏逆向思路源于[ios游戏This war of Mine 辅助开发实录](https://myhloli.com/mod-of-this-war-of-mine.html)



## 开发和使用环境

开发环境：TheOS + MonkeyDev + Xcode

分析工具：静态分析用IDA，动态分析用lldb和debugserver

使用环境：越狱的苹果手机或iPad

开发语言：OC

游戏版本：1.13.1

## 详细步骤

- 在IDA中定位到目标位置

1.把游戏的二进制文件“TWoM”拖入IDA分析，选择分析64位版本。

2.分析完成，打开“Strings window”窗口，搜索"GodMode"关键字，可以得到“GodMode Enabled”和“GodMode Disabled”，根据搜索结果查看对应的汇编语句。
![搜索结果](./image/0@2x.png)
3.
