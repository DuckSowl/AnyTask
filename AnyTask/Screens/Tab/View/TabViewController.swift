//
//  TabViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 29.06.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {
    
    var addTaskViewController: AddTaskViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        let tabBarView = TabBarView()
        view.addSubview(tabBarView)
        
        tabBarView.pin.sides().bottom().activate
        
        let taskViewController = TaskTableViewController()
        guard let taskView = taskViewController.view else { return }
        self.addChild(taskViewController)
        view.insertSubview(taskView, at: 0)
        taskViewController.didMove(toParent: self)
        
        taskView.pin.sides().top().bottom(to: tabBarView).activate
        
        tabBarView.delegate = self
    }
}

extension TabViewController: TabBarDelegate {
    func didSelect(tab: Tab) {
        view.backgroundColor = UIColor(red: CGFloat.random(in: 0.2...0.8), green: CGFloat.random(in: 0.2...0.8), blue: CGFloat.random(in: 0.2...0.8), alpha: 1)
    }
    
    func didPressAdd() {
        addTaskViewController = AddTaskViewController()
        addTaskViewController.view.frame = view.frame
        self.addChild(addTaskViewController)
        view.addSubview(addTaskViewController.view)
        addTaskViewController.didMove(toParent: self)
    }
}
