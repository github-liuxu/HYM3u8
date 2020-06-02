//
//  AVPlayerViewControllerSwizzled.swift
//  HYM3u8
//
//  Created by 刘东旭 on 2020/5/11.
//  Copyright © 2020 刘东旭. All rights reserved.
//

import Foundation
import AVKit

extension AVPlayerViewController {
    
    @objc func myViewDidLoad() {
        myViewDidLoad()
        print("myViewDidLoad")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            let button = UIButton()
            button.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
            button.backgroundColor = .red
            button.addTarget(self, action: #selector(self.buttonClick), for: .touchUpInside)
            self.presentedViewController?.view.addSubview(button)
        }
    }

    @objc func buttonClick() {
        
        let window = UIApplication.shared.windows.last!
        UIApplication.shared.windows.forEach { (window) in
            let vc = window.rootViewController
            print(vc?.classForCoder)
        }
//        let bb = window.rootViewController
//        bb!.view.subviews.forEach { (view) in
//            print(view.classForCoder)
//            view.removeFromSuperview()
//        }
//        let aa = self.delegate
//        self.view.subviews.forEach { (view) in
//            print(view.classForCoder)
//        }
    }
    
}
