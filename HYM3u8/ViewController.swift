//
//  ViewController.swift
//  HYM3u8
//
//  Created by 刘东旭 on 2020/5/5.
//  Copyright © 2020 刘东旭. All rights reserved.
//

import UIKit
import WebKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var titleName = ""
    var urlString = ""
    var isCount = false
    var count = 0
    var isGetList = false
    var list = Array<String>()
    var ii = 0
    var aa:Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webView.load(URLRequest(url: URL(string: "https://www.huya.com/g/seeTogether")!))
        webView.uiDelegate = self
        print(NSHomeDirectory())
        
    }
    
    

    @IBAction func getCount(_ sender: Any) {
        isCount = true
        var jj = "var videos = document.getElementsByClassName('clickstat g-link'); alert(videos.length)"
        self.webView.evaluateJavaScript(jj) { (any, error) in
            if error != nil {
                print(error as Any)
            }
            if any != nil {
                print(any as Any)
            }
        }
    }
    @IBAction func getInfo(_ sender: Any) {
        isGetList = true
        for i in 0..<count {
            var jj = "var videos = document.getElementsByClassName('clickstat g-link'); alert(videos[\(i)])"
            self.webView.evaluateJavaScript(jj) { (any, error) in
                if error != nil {
                    print(error as Any)
                }
                if any != nil {
                    print(any as Any)
                }
            }
        }
    }
    
    @IBAction func load(_ sender: Any) {
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                if self.aa == true {
                    if self.ii >= self.list.count {
                        timer.invalidate()
                        return
                    }
                    print("get: \(self.ii)")
                    let string = self.list[self.ii]
                    self.webView.load(URLRequest(url: URL(string: string)!))
                    self.ii += 1
                    self.aa = false
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                        self.getListInfo()
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    func getListInfo() {
        let titleJs = "var videos = document.getElementsByClassName('video_hd_title'); alert(videos[0].childNodes[0].nodeValue)"
        self.webView.evaluateJavaScript(titleJs) { (any, error) in
            if error != nil {
                print(error as Any)
            }
            if any != nil {
                print(any as Any)
            }
        }
        
        let js = "var videos = document.getElementsByTagName('video'); alert(videos[0].currentSrc)"
        self.webView.evaluateJavaScript(js) { (any, error) in
            if error != nil {
                print(error as Any)
            }
            if any != nil {
                print(any as Any)
            }
        }
    }
}

extension ViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        if isCount {
            isCount = false
            count = Int(message)!
            completionHandler()
            return
        }
        if isGetList {
            list.append(message)
            if list.count == count {
                isGetList = false
            }
            completionHandler()
            return
        }
        let urls = message.split(separator: "?")
        if urls.count == 1 {
            titleName = String(urls.first!)
            completionHandler()
        } else if urls.count == 2 {
            var url: String = String(urls.first!)
            if (url.contains("_2500.m3u8")) {
                url = (url.replacingOccurrences(of: "_2500.m3u8", with: ".m3u8"))
            }
            let ll = url.split(separator: "/")
            urlString = "https://hw.hls.huya.com/src/" + ll.last!
            let sss = titleName + "," + urlString
            print(sss)
            let doc = NSHomeDirectory() + "/Documents/huya.txt"
            let fm = FileManager.default
            if !fm.fileExists(atPath: doc) {
                fm.createFile(atPath: doc, contents: nil, attributes: nil)
            }
            let txtString = try! String(contentsOfFile: doc)
            let fh = try! FileHandle.init(forWritingTo: URL(fileURLWithPath: doc))
            fh.write((txtString + sss + "\n").data(using: .utf8)!)
            completionHandler()
            aa = true
            return
        }
    }
}

//
