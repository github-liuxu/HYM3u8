//
//  MyViewController.swift
//  HYM3u8
//
//  Created by 刘东旭 on 2020/5/11.
//  Copyright © 2020 刘东旭. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
//    @objc func myyViewDidLoad() {
//        myyViewDidLoad()
//        print("我是谁" + NSStringFromClass(self.classForCoder));
//        if "AVFullScreenViewController" == NSStringFromClass(self.classForCoder) {
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
//                let button = UIButton()
//                button.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
//                button.backgroundColor = .red
//                button.addTarget(self, action: #selector(self.button1Click), for: .touchUpInside)
//                self.view.addSubview(button)
//            }
//        }
//    }
    
    @objc func myaddSubview(_ view: UIView) {
        myaddSubview(view)
//        print("我是谁" + NSStringFromClass(self.classForCoder));
        if "AVButton" == NSStringFromClass(self.classForCoder) {
            if self.accessibilityIdentifier == "Play/Pause" {
                
            }
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {

//            }
        }
    }
    
    @objc func button1Click() {
        printSubView(view: self)
    //        let aa = self.delegate
    //        self.view.subviews.forEach { (view) in
    //            print(view.classForCoder)
    //        }
    }
    
    func printSubView(view:UIView) {
        if view.subviews.count == 0 {
            print(view.classForCoder)
        } else {
            view.subviews.forEach { (view) in
                print(view.classForCoder)
            }
        }
    }
}
