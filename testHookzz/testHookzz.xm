
#import <UIKit/UIKit.h>

#import "hookzz.h"
#import <mach-o/dyld.h>
#import <dlfcn.h>
#include <unistd.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>
#import <substrate.h>


#include <stdio.h>



//---------wowar-------------
//打印日志
int (*old_sub_10025F9EC)(char * a1,int a2,int a3,const char * a4);

int new_sub_10025F9EC(char * a1,int a2,int a3,const char * a4)
{
    //NSLog(@"测试---1--arg1=%s; arg2=%s",arg1,arg2);
    NSLog(@"测试---日志：%s",a4);
    
    int result = old_sub_10025F9EC(a1,a2,a3,a4);
    
    
    return result;
    
    
}

//打印寄存器的值
void getpid_pre_call_sub_10025F9EC(RegState *rs, ThreadStack *threadstack, CallStack *callstack)
{
    NSLog(@"测试---x8 is:开始");
    
    unsigned long request = *(unsigned long *)(&rs->general.regs.x8);

    NSLog(@"测试---request(x8) is: %ld\n", request);
    
    //修改x8寄存器的值为4
    *(&rs->general.regs.x8) = 4;
    
    unsigned long request2 = *(unsigned long *)(&rs->general.regs.x8);
    
    NSLog(@"测试---request(x8) 修改后is: %ld\n", request2);
    
    return;
    
}

void getpid_half_call_sub_10025F9EC(RegState *rs, ThreadStack *threadstack, CallStack *callstack)
{
    
}




%ctor
{
    NSLog(@"测试===加载我的战争dylib---start");
    
    //sub_10025F9EC函数对应的地址
    unsigned long _sub_10025F9EC = (_dyld_get_image_vmaddr_slide(0) + 0x10025F9EC);
    
    //替换函数
    MSHookFunction((void *)_sub_10025F9EC, (void *)&new_sub_10025F9EC, (void **)&old_sub_10025F9EC);
    
    //修改汇编中的寄存器
    void *hack_this_function_ptr = (void *)(_dyld_get_image_vmaddr_slide(0) + 0x10015CC40);
    
    ZzBuildHookAddress((void *)((unsigned long)hack_this_function_ptr + 0x100), (void *)((unsigned long)hack_this_function_ptr + 0x104), getpid_pre_call_sub_10025F9EC, getpid_half_call_sub_10025F9EC,TRUE);
    
    ZzEnableHook((void *)((unsigned long)hack_this_function_ptr + 0x100));
    
    
    NSLog(@"测试===加载我的战争dylib---over");

    /*
     打印如下：
     Dec 18 22:41:16 Kainuo-kwj TWoM[95161] <Warning>: 测试---x8 is:开始
     Dec 18 22:41:16 Kainuo-kwj TWoM[95161] <Warning>: 测试---request(x8) is: 0
     Dec 18 22:41:16 Kainuo-kwj TWoM[95161] <Warning>: 测试---request(x8) 修改后is: 4
     Dec 18 22:41:16 Kainuo-kwj TWoM[95161] <Warning>: 测试---日志：GodMode Enabled
     */
    
}

