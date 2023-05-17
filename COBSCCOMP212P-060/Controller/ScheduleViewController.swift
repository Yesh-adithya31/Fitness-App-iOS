//
//  ScheduleViewController.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-17.
//

import UIKit

// MARK: CUSTOM Schedule : Add , View, Delete and Update
class ScheduleViewController: UIViewController {
    private var tableView: UITableView!
    private var workoutSessions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the table view
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = UIColor(named: "Black")
        tableView.separatorColor = UIColor(named: "Green")
        view.addSubview(tableView)
        
        // Set up the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWorkoutSession))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "Green")
        navigationItem.title = "Create Schedule"
        // Set the navigation bar title text color
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "White") as Any]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func addWorkoutSession() {
        let alertController = UIAlertController(title: "Add Workout Session", message: nil, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Workout session name"
            textField.font = UIFont.systemFont(ofSize: 18)
            
        }
        alertController.addTextField { textField in
            textField.placeholder = "Enter time(ex: 3:00 AM)"
            textField.font = UIFont.systemFont(ofSize: 18)
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            var val1 = ""
            var val2 = ""
            if let sessionName = alertController.textFields?.first?.text, !sessionName.isEmpty {
                val1 = sessionName
            }
            if let sessionTime = alertController.textFields?.last?.text, !sessionTime.isEmpty {
                if Validator.isTimeValid(for: sessionTime){
                    val2 = sessionTime
                    self?.workoutSessions.append(val2+" - "+val1)
                    self?.tableView.reloadData()
                }
                
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutSessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = workoutSessions[indexPath.row]
        cell.backgroundColor = UIColor(named: "Black")
        cell.textLabel?.textColor = UIColor(named: "White")
        cell.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Edit Workout Session", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Workout session name"
            textField.text = self.workoutSessions[indexPath.row]
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            if let sessionName = alertController.textFields?.first?.text, !sessionName.isEmpty {
                self?.workoutSessions[indexPath.row] = sessionName
                self?.tableView.reloadData()
            }
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.workoutSessions.remove(at: indexPath.row)
            self?.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

