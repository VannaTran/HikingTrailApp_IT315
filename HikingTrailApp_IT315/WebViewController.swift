//
//  WebViewController.swift
//  HikingTrailApp_IT315
//
//  Created by Vanna Tran on 4/16/23.
//

import Foundation
import WebKit

class WebViewController : UIViewController
{
    
    @IBOutlet var webviewSite: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let siteURL = URL(string: PassedHikingTrail.TrailWebSiteAddress)
        let request = URLRequest(url:siteURL!)
        webviewSite.load(request)
    }
    
    var PassedHikingTrail = HikingTrail()
    
}
