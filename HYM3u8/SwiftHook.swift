//
//  SwiftHook.swift
//  HYM3u8
//
//  Created by 刘东旭 on 2020/5/5.
//  Copyright © 2020 刘东旭. All rights reserved.
//

import UIKit
private let onceToken = "Method Swizzling"
extension NSObject {
    class func registerHook(originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        //在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
        let didAddMethod: Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        print(didAddMethod)
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
    
    class func registerHook(origin: AnyClass ,originalSelector: Selector, replace: AnyClass, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(origin, originalSelector)
        let swizzledMethod = class_getInstanceMethod(replace, swizzledSelector)

        method_exchangeImplementations(originalMethod!, swizzledMethod!)

    }

}
//extension DispatchQueue {
//    private static var _onceTracker = [String]()
//    public class func once(token: String, block: () -> ()) {
//           objc_sync_enter(self)
//        defer {
//            objc_sync_exit(self)
//        }
//        if _onceTracker.contains(token) {
//            return
//        }
//        _onceTracker.append(token)
//        block()
//    }
//
//    func async(block: @escaping ()->()) {
//        self.async(execute: block)
//    }
//
//    func after(time: DispatchTime, block: @escaping ()->()) {
//        self.asyncAfter(deadline: time, execute: block)
//    }
//}
