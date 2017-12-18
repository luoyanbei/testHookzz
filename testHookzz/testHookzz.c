//
//  testHookzz.c
//  testHookzz
//
//  Created by King on 2017/12/16.
//
//

#include "testHookzz.h"

//#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "hookzz.h"
#import <mach-o/dyld.h>
#import <dlfcn.h>
#include <unistd.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>


int (*old_sub_100009774)(char*,char*);

int new_sub_100009774(char * arg1,char *arg2)
{
    
    printf("测试---hook成功");
    
    int result = old_sub_100009774(arg1,arg2);
    
    printf("测试-- （ %s : %d ）",arg2,result);
    
    return result;
    
}



static __attribute__((constructor)) void _logosLocalCtor_34173cb3(int __unused argc, char __unused **argv, char __unused **envp)
{
    
    unsigned long _sub_100009774 = (_dyld_get_image_vmaddr_slide(0) + 0x100009774);
    
    ZzBuildHook((void *)_sub_100009774, (void *)&new_sub_100009774, (void **)&old_sub_100009774, nil, nil);
    
    
    
    
    printf("测试---替换成功");
    
}
