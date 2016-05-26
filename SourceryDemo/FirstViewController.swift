//
//  FirstViewController.swift
//  SourceryDemo
//
//  Created by Marius Constantinescu on 24/05/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import UIKit
import Sourcery

class FirstViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var textSourcery : SimpleSourcery<String, BasicCell>?
    let textDataSource = ["One", "Two", "Three"]
    
    
    var imageSourcery : SimpleSourcery<UIImage, ImageCell>?
    let imageDataSource = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!]
    
    
    var complexSourcery : ComplexSourcery?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    
//        textSourcery = SimpleSourcery<String, BasicCell>(tableView: tableView, data: textDataSource, configurator: { (cell, index, object) in
//            cell.textLabel?.text = object
//        })
 
        
//        imageSourcery = SimpleSourcery<UIImage, ImageCell>(tableView: tableView, data: imageDataSource, configurator: { (cell, index, object) in
//            cell.cellImageView.image = object
//        })
        
        
        let textSection = Section<String, BasicCell>(title: "Text", data: textDataSource, configurator: { (cell, index, object) in
            cell.textLabel?.text = object
            }, selectionHandler: nil)
        
        let imageSection = Section<UIImage, ImageCell>(title: "Images", data: imageDataSource, configurator: { (cell, index, object) in
            cell.cellImageView.image = object
            }, selectionHandler: nil)

        let clickableTextSection = Section<String, BasicCell>(title: "Text", data: textDataSource, configurator: { (cell, index, object) in
            cell.textLabel?.text = object
            }, selectionHandler: { (index, object) in
                UIAlertView(title: nil, message: object, delegate: nil, cancelButtonTitle: "Ok").show()
        })
        
        complexSourcery = ComplexSourcery(tableView: tableView, sections: [textSection, imageSection, clickableTextSection])
    }

}


