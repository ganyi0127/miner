//
//  Time.swift
//  SDKSwiftSimple
//
//  Created by ganyi on 16/7/5.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import Foundation

typealias Task = (cancel:Bool)->()

func delay(time:NSTimeInterval,task:()->()) -> Task? {
    
    func dispatch_later(block:()->()){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block)
    }
    
    var closure:dispatch_block_t? = task
    var result:Task?
    
    let delayedClosure:Task = {
        cancel in
        if let internalClosure = closure {
            if !cancel {
                dispatch_async(dispatch_get_main_queue(), internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later(){
        if let delayedClosure = result{
            delayedClosure(cancel: false)
        }
    }
    return result
}

func cancel(task:Task?) {
    task?(cancel: true)
}

func mainThread(closure:()->()) {
    dispatch_async(dispatch_get_main_queue(), closure)
}

func globalThread(closure:()->()){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), closure)
}