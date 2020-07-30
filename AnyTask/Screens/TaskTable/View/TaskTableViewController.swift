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

        tableView.register(TaskCellView.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.backgroundColor = Color.background
        tableView.separatorColor = Color.clear
    }

    // MARK: - UITableViewDataSourse

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as! TaskCellView

        cell.viewModel = TaskCellViewModel(task: tasks[indexPath.row])

        return cell
    }
}
