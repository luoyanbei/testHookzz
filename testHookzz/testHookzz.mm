#line 1 "/Users/king/Documents/GitHub/testHookzz/testHookzz/testHookzz.xm"

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





int (*old_sub_10025F9EC)(char * a1,int a2,int a3,const char * a4);

int new_sub_10025F9EC(char * a1,int a2,int a3,const char * a4)
{
    
    NSLog(@"测试---日志：%s",a4);
    
    int result = old_sub_10025F9EC(a1,a2,a3,a4);
    
    
    return result;
    
    
}


void getpid_pre_call_sub_10025F9EC(RegState *rs, ThreadStack *threadstack, CallStack *callstack)
{
    NSLog(@"测试---x8 is:开始");
    
    unsigned long request = *(unsigned long *)(&rs->general.regs.x8);
    
    NSLog(@"测试---request(x8) is: %ld\n", request);
    
    
    *(&rs->general.regs.x8) = 4;
    
    unsigned long request2 = *(unsigned long *)(&rs->general.regs.x8);
    
    NSLog(@"测试---request(x8) 修改后is: %ld\n", request2);
    
    return;
    
}

void getpid_half_call_sub_10025F9EC(RegState *rs, ThreadStack *threadstack, CallStack *callstack)
{
    
}





void printf_pre_call(RegState *rs, ThreadStack *threadstack, CallStack *callstack) {
   
    
    NSLog(@"printf-pre-call");
}

void printf_post_call(RegState *rs, ThreadStack *threadstack, CallStack *callstack) {
   
    NSLog(@"printf-post-call");
}







static __attribute__((constructor)) void _logosLocalCtor_f033ab37(int __unused argc, char __unused **argv, char __unused **envp)
{
    NSLog(@"测试===加载我的战争dylib---start-1");
    
    
    unsigned long _sub_10025F9EC = (_dyld_get_image_vmaddr_slide(0) + 0x10025F9EC);
    void *hack_sub_10025F9EC = (void *)_sub_10025F9EC;
    
    
    ZzBuildHook((void *)hack_sub_10025F9EC, (void *)new_sub_10025F9EC, (void **)&old_sub_10025F9EC, printf_pre_call, printf_post_call,TRUE);
    ZzEnableHook((void *)hack_sub_10025F9EC);
    
    
    
    
    
    
    
    
    
    
    void *hack_this_function_ptr = (void *)(_dyld_get_image_vmaddr_slide(0) + 0x10015CC40);
    
    ZzBuildHookAddress((void *)((unsigned long)hack_this_function_ptr + 0x100), (void *)((unsigned long)hack_this_function_ptr + 0x104), getpid_pre_call_sub_10025F9EC, getpid_half_call_sub_10025F9EC,TRUE);
    
    ZzEnableHook((void *)((unsigned long)hack_this_function_ptr + 0x100));
    
    
    NSLog(@"测试===加载我的战争dylib---over");

    






    
}

