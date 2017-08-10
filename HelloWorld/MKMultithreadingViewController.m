//
//  MKMultithreadingViewController.m
//  HelloWorld
//
//  Created by Camel on 2017/1/10.
//  Copyright © 2017年 Camel. All rights reserved.
//

#import "MKMultithreadingViewController.h"

@interface MKMultithreadingViewController () {
    dispatch_source_t _processingQueueSource;
    dispatch_queue_t _queue;
}

@property (atomic, assign, getter=isRunning) BOOL running;

@end

@implementation MKMultithreadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dispatchSemaphoreMultithreading];
    [self checkGetCurrentQueueAndGetMainQueue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self changeStatus:self.running];
}

- (void)checkGetCurrentQueueAndGetMainQueue {
#pragma clang diagnostic push 
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    dispatch_queue_t current_queue = dispatch_get_current_queue();
#pragma clang diagnostic pop
    dispatch_queue_t main_queue = dispatch_get_main_queue();
    
    debugLog(@"current_queue %@",current_queue);
    debugLog(@"main_queue %@",main_queue);
}

- (void)deadlock {
    dispatch_queue_t queueA = dispatch_queue_create("com.camel.queueA", NULL);
}

/**
 主线程上同步执行一个任务
 */
- (void)syncOnMainQueue {
    dispatch_sync(dispatch_get_main_queue(), ^{
        debugLog(@"sync in block");
    });
    debugLog(@"sync out of block");
}

/**
 主线程上异步执行一个任务
 */
- (void)asyncOnMainQueue {
    dispatch_async(dispatch_get_main_queue(), ^{
        debugLog(@"aysn in block");
    });
    debugLog(@"asyn out of block");
}

#pragma mark dispatch semaphore

/**
 控制并发量的GCD用法，不会阻塞主线程

 @param queue 执行queue
 @param limitSemaphoreCout 控制的最大并发量
 @param block 执行block
 */
void dispatch_async_limit(dispatch_queue_t queue,NSUInteger limitSemaphoreCout,dispatch_block_t block) {
    // 控制并发量的信号量
    static dispatch_semaphore_t limitSemaphore;
    // 专门控制并发等待的线程
    static dispatch_queue_t receiverQueue;
    // 使用dispatch_once而非lazy模式，防止可能存在的多线程抢占的问题
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        limitSemaphore = dispatch_semaphore_create(limitSemaphoreCout);
        receiverQueue = dispatch_queue_create("receiver", DISPATCH_QUEUE_SERIAL);
    });
    
    dispatch_async(receiverQueue, ^{
       //有可用信号量时才能继续，否则等待
        dispatch_semaphore_wait(limitSemaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(queue, ^{
            if (block) {
                block();
            }
            // 在工作线程执行完成任务之后释放信号量
            dispatch_semaphore_signal(limitSemaphore);
        });
    });
}

/*
 *
 简单版本：无专门控制并发等待的线程，缺点阻塞主线程，可以跑一下 demo，你会发现主屏幕上的按钮是不可点击的
 *
 */
//void dispatch_async_limit(dispatch_queue_t queue,NSUInteger limitSemaphoreCount, dispatch_block_t block) {
//    //控制并发数的信号量
//    static dispatch_semaphore_t limitSemaphore;
//    //专门控制并发等待的线程
//    
//    
//    //使用 dispatch_once而非 lazy 模式，防止可能的多线程抢占问题
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        limitSemaphore = dispatch_semaphore_create(limitSemaphoreCount);
//    });
//    
//    
//    //可用信号量后才能继续，否则等待
//    dispatch_semaphore_wait(limitSemaphore, DISPATCH_TIME_FOREVER);
//    dispatch_async(queue, ^{
//        !block ? : block();
//        //在该工作线程执行完成后释放信号量
//        dispatch_semaphore_signal(limitSemaphore);
//    });
//    
//}

- (void)dispatchSemaphoreMultithreading {
    dispatch_semaphore_t signal;
    signal = dispatch_semaphore_create(1);
    __block long x = 0;
    NSLog(@"0_x:%ld",x);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        NSLog(@"waiting");
        x = dispatch_semaphore_signal(signal); //这个时候先log 1_x 还是先 wait 2是不确定的，因为不在一个线程的队列上
        
        NSLog(@"1_x:%ld",x);
        
        sleep(2);
        NSLog(@"waking");
        x = dispatch_semaphore_signal(signal);
        NSLog(@"2_x:%ld",x);
    });
        dispatch_time_t duration = dispatch_time(DISPATCH_TIME_NOW, 1*1000*1000*1000); //超时1秒
//        dispatch_semaphore_wait(signal, duration);
    
    x = dispatch_semaphore_wait(signal, duration);
    NSLog(@"3_x:%ld",x);
    
    x = dispatch_semaphore_wait(signal, duration);
    NSLog(@"wait 2");
    NSLog(@"4_x:%ld",x);
    
    x = dispatch_semaphore_wait(signal, duration);
    NSLog(@"wait 3");
    NSLog(@"5_x:%ld",x);
    dispatch_semaphore_signal(signal);
}

- (void)dispatchSemaphore {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    //    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);//等待一秒
    dispatch_time_t time = DISPATCH_TIME_FOREVER;//永久等待
    NSLog(@"begin ==>  车库开始营业了！");
    /*
     *
     如果 semphore 的值等于0，就阻塞1秒钟，才会往下照常进行；
     如果大于等于1则往下进行并将 semphore 进行减1处理。
     *
     */
    long result = dispatch_semaphore_wait(semaphore, time);
    if (result == 0) {
        /*
         *
         *由子Dispatch Semaphore的计数值达到大于等于1
         *或者在待机中的指定时间内
         *Dispatch Semaphore的计数值达到大于等于1
         所以Dispatch Semaphore的计数值减去1
         可执行需要进行排他控制的处理.
         可以理解为：没有阻塞的线程了。
         就好比：车库有一个或一个以上的车位，只来了一辆车，所以“无需等待”
         *
         */
        NSLog(@"result = 0 ==> 有车位，无需等待！==> 在这里可安全地执行【需要排他控制的处理（比如只允许一条线程为mutableArray进行addObj操作）】");
        dispatch_semaphore_signal(semaphore);//使用signal以确保编译器release掉dispatch_semaphore_t时的值与初始值一致， 否则会EXC_BAD_INSTRUCTION ,见http://is.gd/EaJgk5
    } else {
        /*
         *
         *由于Dispatch Semaphore的计数值为0
         .因此在达到指定时间为止待机
         这个else里发生的事情，就好比：车库没车位，来了一辆车，等待了半个小时后，做出的一些事情。
         比如：忍受不了，走了。。
         *
         */
        NSLog(@"result != 0 ==> timeout，deadline，忍受不了，走了。。");
        
    }
    
}


#pragma makr dispatch suspend resume (GCD的挂起和恢复)

- (void)gcdSuspendAndResume {
    //1.
    // 指定DISPATCH_SOURCE_TYPE_DATA_ADD，做成Dispatch Source(分派源)。设定Main Dispatch Queue 为追加处理的Dispatch Queue
    _processingQueueSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0,
                                                    dispatch_get_main_queue());
    __block NSUInteger totalComplete = 0;
    dispatch_source_set_event_handler(_processingQueueSource, ^{
        //当处理事件被最终执行时，计算后的数据可以通过dispatch_source_get_data来获取。这个数据的值在每次响应事件执行后会被重置，所以totalComplete的值是最终累积的值。
        NSUInteger value = dispatch_source_get_data(_processingQueueSource);
        totalComplete += value;
        NSLog(@"进度：%@", @((CGFloat)totalComplete/1000));
//        NSLog(@"🔵线程号：%@", [NSThread currentThread]);
    });
    //分派源创建时默认处于暂停状态，在分派源分派处理程序之前必须先恢复。
    [self resume];
    
    //2.
    //恢复源后，就可以通过dispatch_source_merge_data向Dispatch Source(分派源)发送事件:
    
    
    _queue = dispatch_queue_create("com.camel.helloworld", DISPATCH_QUEUE_SERIAL);

//    dispatch_async(queue, ^{
//        for (NSUInteger index = 0; index < 100; index++) {
//            dispatch_source_merge_data(_processingQueueSource, 1);
//            NSLog(@"♻️线程号：%@", [NSThread currentThread]);
//            usleep(20000);//0.02秒
//        }
//    });

    //这种方法要比上面的方法快 因为DispatchSource能通过合并事件的方式确保在高负载下正常工作
    for (NSUInteger index = 0; index < 1000; index ++) {
        dispatch_async(_queue, ^{
            if (!self.isRunning) {
                return ;
            }
            dispatch_source_merge_data(_processingQueueSource, 1);
//            NSLog(@"♻️线程号：%@", [NSThread currentThread]);
            usleep(200000);//0.2秒
        });
    }
    
}

- (void)changeStatus:(BOOL)shouldPause {
    if (shouldPause) {
        [self pause];
    } else {
        [self resume];
    }
}

- (void)resume {
    if (self.running) {
        return;
    }
    NSLog(@"✅恢复Dispatch Source(分派源)");
    self.running = YES;
    dispatch_resume(_processingQueueSource);
    if (_queue) {
        dispatch_resume(_queue);
    }
}

- (void)pause {
    if (!self.running) {
        return;
    }
    NSLog(@"🚫暂停Dispatch Source(分派源)");
    self.running = NO;
    dispatch_suspend(_processingQueueSource);
    dispatch_suspend(_queue);
}

#pragma mark dispatch_barrier

/**
 dispatch_barrier在系统的全局queue中的是起不到想要的作用的
 */
- (void)barrierAsyncOnGCDGlobalQueue {
    dispatch_queue_t dataQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:2.f];
        debugLog(@"globalQueue read data 1");
    });
    dispatch_async(dataQueue, ^{
        debugLog(@"globalQueue read data 2");
    });
    //等待前面的都执行完之后，在执行barrier后面的，在当前的队列中只有barrier中的block会执行
    dispatch_barrier_async(dataQueue, ^{
        debugLog(@"globalQueue write data 1");
        [NSThread sleepForTimeInterval:1.f];
    });
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:1.f];
        debugLog(@"globalQueue read data 3");
    });
    dispatch_async(dataQueue, ^{
        debugLog(@"globalQueue read data 4");
    });
    
}

/**
 dispatch_barrier在自己创建的queue上的作用
 执行结果如下 read data 2,read data 1,write data 1,read data 4,read data 3
 */
- (void)barrierAsyncOnPersonalConcurrentQueue {
    //barrie可以保证在block中的任务在某个时间之内一定是只有当前的任务
    //-------(task one)     barrier             ----(task five)
    //-------(task two)     -------(task four)  ----(task six)
    //-------(task three)                       ----(task seven)
    //
    //防止文件读写冲突，可以创建一个并行队列，操作都在这个队列里进行，读用并行，写用串行
    dispatch_queue_t dataQueue = dispatch_queue_create("com.camel.helloworld.dataqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:2.f];
        debugLog(@"read data 1");
    });
    dispatch_async(dataQueue, ^{
        debugLog(@"read data 2");
    });
    //等待前面的都执行完之后，在执行barrier后面的，在当前的队列中只有barrier中的block会执行
    dispatch_barrier_async(dataQueue, ^{
        debugLog(@"write data 1");
        [NSThread sleepForTimeInterval:1.f];
    });
    dispatch_async(dataQueue, ^{
        [NSThread sleepForTimeInterval:1.f];
        debugLog(@"read data 3");
    });
    dispatch_async(dataQueue, ^{
        debugLog(@"read data 4");
    });
    
}

@end
