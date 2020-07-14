//
//  TaskTableViewController.swift
//  AnyTask
//
//  Created by Anton Tolstov on 14.07.2020.
//  Copyright © 2020 Anton Tolstov. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    // Example tasks
    let tasks: [Task] = (1...30).map { _ in Task.example }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        tableView.separatorColor = .clear
    }

    // MARK: - UITableViewDataSourse

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as! TaskTableViewCell

        cell.viewModel = TaskViewModel(task: tasks[indexPath.row])

        return cell
    }
}
