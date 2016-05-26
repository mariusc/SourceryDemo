//
// ViewController.swift
//
// Created by Alek Åström on 2015-02-14.
// Copyright (c) 2015 Alek Åström. (https://github.com/MrAlek)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import PagedArray

// Tweak these values and see how the user experience is affected
let PreloadMargin = 10 /// How many rows "in front" should be loaded
let PageSize = 25 /// Paging size
let DataLoadingOperationDuration = 0.5 /// Simulated network operation duration
let TotalCount = 200 /// Number of rows in table view


class ViewController: UITableViewController {

    let cellIdentifier = "Cell"
    let operationQueue = NSOperationQueue()
    
    var pagedArray = PagedArray<String>(count: TotalCount, pageSize: PageSize)
    var dataLoadingOperations = [Int: NSOperation]()
    var shouldPreload = true
    
    // MARK: User actions
    
    @IBAction func clearDataPressed() {
        dataLoadingOperations.removeAll(keepCapacity: true)
        operationQueue.cancelAllOperations()
        pagedArray.removeAllPages()
        tableView.reloadData()
    }
    
    @IBAction func preLoadingSwitchChanged(sender: UISwitch) {
        shouldPreload = sender.on
    }
    
    // MARK: Private functions
    
    private func configureCell(cell: UITableViewCell, data: String?) {
        cell.textLabel!.text = data ?? ""
    }
    
    private func loadDataIfNeededForRow(row: Int) {
        
        let currentPage = pagedArray.pageNumberForIndex(row)
        if needsLoadDataForPage(currentPage) {
            loadDataForPage(currentPage)
        }
        
        let preloadIndex = row+PreloadMargin
        if preloadIndex < pagedArray.endIndex && shouldPreload {
            let preloadPage = pagedArray.pageNumberForIndex(preloadIndex)
            if preloadPage > currentPage && needsLoadDataForPage(preloadPage) {
                loadDataForPage(preloadPage)
            }
        }
    }
    
    private func needsLoadDataForPage(page: Int) -> Bool {
        return pagedArray.pages[page] == nil && dataLoadingOperations[page] == nil
    }
    
    private func loadDataForPage(page: Int) {
        let indexes = pagedArray.indexes(page)

        // Create loading operation
        let operation = DataLoadingOperation(indexesToLoad: indexes) { [unowned self] indexes, data in
            
            // Set elements on paged array
            self.pagedArray.setElements(data, pageIndex: page)
            
            // Reload cells
            if let indexPathsToReload = self.visibleIndexPathsForIndexes(indexes) {
                self.tableView.reloadRowsAtIndexPaths(indexPathsToReload, withRowAnimation: .Automatic)
            }
            
            // Cleanup
            self.dataLoadingOperations[page] = nil
        }

        // Add operation to queue and save it
        operationQueue.addOperation(operation)
        dataLoadingOperations[page] = operation
    }
    
    private func visibleIndexPathsForIndexes(indexes: Range<Int>) -> [NSIndexPath]? {
        return tableView.indexPathsForVisibleRows?.filter { indexes.contains($0.row) }
    }
    
}

// MARK: Table view datasource
extension ViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagedArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        loadDataIfNeededForRow(indexPath.row)

        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)!
        configureCell(cell, data: pagedArray[indexPath.row])
        return cell
    }
    
}


/// Test operation that produces nonsense numbers as data
class DataLoadingOperation: NSBlockOperation {
    
    init(indexesToLoad: Range<Int>, completion: (indexes: Range<Int>, data: [String]) -> Void) {
        super.init()
        
        print("Loading indexes: \(indexesToLoad)")
        
        addExecutionBlock {
            // Simulate loading
            NSThread.sleepForTimeInterval(DataLoadingOperationDuration)
        }
        
        completionBlock = {
            let data = indexesToLoad.map { "Content data \($0)" }
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                completion(indexes: indexesToLoad, data: data)
            }
        }
    }
    
}
