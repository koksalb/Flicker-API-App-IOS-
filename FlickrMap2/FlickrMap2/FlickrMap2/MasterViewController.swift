//
//  MasterViewController.swift
//  FlickrMap2
//
//  Created by Student Eurecom on 1/8/18.
//  Copyright © 2018 eurecom. All rights reserved.
//



import UIKit
import MapKit


class MasterViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var map: MKMapView!
    
    var kml: KMLParser!
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var detail: DetailViewController!
    var images: NSMutableArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.images = NSMutableArray()
        
        let url = NSURL(string: "https://www.flickr.com/services/feeds/geo/fr?format=kml&page=1") as URL!
        self.kml = KMLParser.parseKML(at: url as URL!)
        let annotations : NSArray = kml.points as NSArray
        
        //PROBLEM LINE!
        map.delegate = self
        
        
        map.addAnnotations(annotations as! [MKAnnotation])
        map.visibleMapRect = kml.pointsRect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) ->
        MKAnnotationView? {
            let pin: MKAnnotationView = kml.view(for: annotation)
            let rightButton: UIButton! = UIButton(type: UIButtonType.detailDisclosure)
            rightButton.addTarget(self, action: #selector(showDetail),
                                  for:UIControlEvents.touchUpInside)
            rightButton.tag = images.count
            let url = kml.imageURL(for: annotation)
            self.images.add(url)
            pin.rightCalloutAccessoryView = rightButton
            return pin;
    }
    
    @objc func showDetail(sender: UIButton) {
        self.detailViewController = storyboard!.instantiateViewController(withIdentifier:
            "DetailViewController") as? DetailViewController
        let button = sender
        self.detailViewController!.images = self.images
        self.navigationController?.pushViewController(self.detailViewController!, animated: true)
        self.detailViewController?.loadimage(index: button.tag)
    }
}
