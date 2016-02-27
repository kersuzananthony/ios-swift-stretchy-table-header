//
//  ViewController.swift
//  Table View Header Test
//
//  Created by Kersuzan on 28/12/2015.
//  Copyright © 2015 Kersuzan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate
{
    
    @IBOutlet var tableView: UITableView!
    
    var items: [Item] = [Item]()
    var headerView: UIView!
    let tableViewHeaderHeight: CGFloat = 300.0
    var headerMaskLayer: CAShapeLayer!
    
    var phoneHeight: CGFloat!
    
    private let tableViewCutAway: CGFloat = 80.0
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Print the height of the phone
        print("Phone height \(UIScreen.mainScreen().bounds.height)")
        self.phoneHeight = UIScreen.mainScreen().bounds.height
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        
        items.append(Item(title: "First item", subTitle: "First description"))
        items.append(Item(title: "Second item", subTitle: "Second description"))
        
        // Manage the table View, first we save the initial tableHeaderView in our own variable which we want to manage ourself
        self.headerView = self.tableView.tableHeaderView
        
        // We delete the tableHeaderView because we dont want the tableView manage the header itself
        self.tableView.tableHeaderView = nil
        
        // Add our own custom view to the TableView
        self.tableView.addSubview(self.headerView)
        
        print("Height subView \(self.headerView.frame.height)")
        
        self.tableView.contentInset = UIEdgeInsets(top: self.phoneHeight, left: 0, bottom: 0, right: 0)
        self.tableView.contentOffset = CGPoint(x: 0, y: -self.phoneHeight)
        
        updateTableWithPhoneHeader()
        
        let effectiveHeight = self.tableViewHeaderHeight - self.tableViewCutAway / 2
        
        // Set inset and offset for pushing the tableView content
        self.tableView.contentInset = UIEdgeInsets(top: effectiveHeight + 1, left: 0, bottom: 0, right: 0)
        self.tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        // Take care of the mask
        self.headerMaskLayer = CAShapeLayer()
        self.headerMaskLayer.fillColor = UIColor.blackColor().CGColor
        self.headerView.layer.mask = self.headerMaskLayer
        
        updateHeaderView()
    }
    
    func updateTableWithPhoneHeader() {
        let headerRect = CGRectMake(0, -self.phoneHeight, self.tableView.bounds.width, self.phoneHeight)
        
        self.headerView.frame = headerRect
    }
    
        func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func updateHeaderView() {
        let effectiveHeight = self.tableViewHeaderHeight - self.tableViewCutAway / 2

        
        var headerRect = CGRectMake(0, -effectiveHeight, self.tableView.bounds.width, self.tableViewHeaderHeight)
        if tableView.contentOffset.y <= -effectiveHeight {
            print("called")
            headerRect.origin.y = self.tableView.contentOffset.y
            headerRect.size.height = -self.tableView.contentOffset.y + self.tableViewCutAway / 2
        }
        
        print("Header view height \(headerRect.size.height)")
        
        self.headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.height - self.tableViewCutAway))
        
        self.headerMaskLayer?.path = path.CGPath
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: CustomTableViewCell!
        
        if let reusableCell = self.tableView.dequeueReusableCellWithIdentifier("customCell") as? CustomTableViewCell {
            cell = reusableCell
            cell.configureCell(items[indexPath.row])
        } else {
            let cell = CustomTableViewCell()
            cell.configureCell(items[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
}

