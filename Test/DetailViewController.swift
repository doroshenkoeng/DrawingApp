//
//  DetailViewController.swift
//  Test
//
//  Created by Сергей Дорошенко on 28/09/2019.
//  Copyright © 2019 Сергей Дорошенко. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
//
//    var imageView = UIImageView()
//
//    var scrollView = UIScrollView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        imageView.frame = self.view.frame
//        if let data = try? Data(contentsOf: URL(string: "https://kbdevstorage1.blob.core.windows.net/asset-blobs/19666_en_1")!) {
//            imageView.image = UIImage(data: data)
//        }
//        scrollView.frame = self.view.frame
//        scrollView.contentSize = imageView.frame.size
//        scrollView.delegate = self
//        scrollView.minimumZoomScale = 0.1
//        scrollView.maximumZoomScale = 2.0
//        scrollView.addSubview(imageView)
//        self.view.addSubview(scrollView)
//    }
//
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        imageView.frame = self.view.frame
        if let data = try? Data(contentsOf: URL(string: "https://kbdevstorage1.blob.core.windows.net/asset-blobs/19666_en_1")!) {
            imageView.image = UIImage(data: data)
        }
        scrollView?.contentSize = self.view.frame.size
        scrollView?.delegate = self
        scrollView?.minimumZoomScale = 0.15
        scrollView?.maximumZoomScale = 1.5
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
    
}
