//
//  ViewController.swift
//  NewsWithStoryboards
//
//  Created by merve kavaklioglu on 19.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet weak var webviewInstance: WKWebView!
    var url: String? 
    override func viewDidLoad() {
        super.viewDidLoad()
        loadURL()
        configureView()
    }
    
    func configureView() {
        navigationItem.title = "Detail"
        view.accessibilityIdentifier = "detail_VC_AI"
    }
}

extension DetailViewController{
    func loadURL()  {
        if let link = URL(string:url!){
            let request = URLRequest(url: link)
            webviewInstance.load(request)}
    }
}
