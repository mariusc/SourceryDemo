//
//  SecondViewController.swift
//  SourceryDemo
//
//  Created by Marius Constantinescu on 24/05/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import UIKit
import Sourcery

class SecondViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    var sourcery: PagedSourcery<Beer, BasicCell>?
    
    var beers = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupSourcery()
    }
    
    
    func setupSourcery() {
        
        sourcery = PagedSourcery<Beer, BasicCell>(tableView: tableView, pageSize: 50, pageLoader: { (page, operationQueue, completion) in
            operationQueue.addOperationWithBlock({
                
                ConnectionManager.fetchBeers(page, completion: { (response) in
                    
                    switch response.result {
                    case .Success(let beerResponse):
                        completion(totalCount: beerResponse.totalResults, data:beerResponse.beers)
                    case .Failure(_):
                        print("error")
                        
                    }
                    
                    })
                })
            }, configurator: { $0.cell.textLabel?.text = $0.object.name })
        sourcery?.startPageIndex = 1
        sourcery?.preloadMargin = nil
    }


}

