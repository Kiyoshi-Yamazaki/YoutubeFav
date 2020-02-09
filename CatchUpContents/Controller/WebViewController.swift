//
//  WebViewController.swift
//  CatchUpContents
//
//  Created by 山崎喜代志 on 2020/02/03.
//  Copyright © 2020 山崎喜代志. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    
    var webView = WKWebView()
    var youtubeURL = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(webView)
        
        let request = URLRequest(url: URL(string: youtubeURL)!)
        webView.load(request)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
