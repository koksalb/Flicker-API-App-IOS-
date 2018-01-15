//
//  DetailViewController.swift
//  FlickrMap2
//
//  Created by Student Eurecom on 1/8/18.
//  Copyright © 2018 eurecom. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    var images: NSMutableArray!
    var currentIndex : Int = 0
    

    
    func loadimage(index: Int){
        currentIndex = index
        DispatchQueue.global(qos: .background).async {
            let imageURL: NSURL! = self.images.object(at: index) as! NSURL
            let data: NSData! = NSData(contentsOf: imageURL as URL)
            print("data size: %d", data!.length)
            DispatchQueue.main.async {
                self.image.image = UIImage(data: data as Data)
                                    }
            
            
        
    }
    
    }
        

        
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

