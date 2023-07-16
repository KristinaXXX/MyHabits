//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Kr Qqq on 16.07.2023.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    private var habit: Habit
    
    private lazy var editBarButtonItem: UIBarButtonItem = {
        let button = UIButton()
        button.setTitle("Править", for: .normal)
        button.addTarget(self, action: #selector(editButtonPressed(_:)), for: .touchUpInside)
        button.setTitleColor(UIColor(named: "HabitPurple"), for: .normal)
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var detailsTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: HabitDetailsTableViewCell.id)
        tableView.backgroundColor = UIColor(named: "HabitGray")
        return tableView
    }()
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        detailsTableView.indexPathsForSelectedRows?.forEach{ indexPath in
            detailsTableView.deselectRow(
                at: indexPath,
                animated: animated
            )
        }
    }
    
    private func addSubviews() {
        view.addSubview(detailsTableView)
        view.backgroundColor = .white
    }
    
    func setupConstraints() {

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            detailsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            detailsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            detailsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func tuneTableView() {
        title = habit.name
        detailsTableView.dataSource = self
        detailsTableView.delegate = self
        detailsTableView.rowHeight = UITableView.automaticDimension
        
        let headerView = HabitDetailsTableHeaderView(title: "АКТИВНОСТЬ")
        detailsTableView.setAndLayout(headerView: headerView)
        
        navigationItem.rightBarButtonItems = [editBarButtonItem]
    }
    
    @objc func editButtonPressed(_ sender: UIButton) {
       
        let habitViewController = HabitViewController(habit: habit)

//        habitViewController.modalTransitionStyle = .coverVertical
//        habitViewController.modalPresentationStyle = .fullScreen
//        present(habitViewController, animated: true)
        
        navigationController?.pushViewController(habitViewController, animated: true)
        
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitDetailsTableViewCell.id, for: indexPath) as! HabitDetailsTableViewCell
        let selectDate = HabitsStore.shared.dates[indexPath.row]
        let dateString = HabitsStore.shared.trackDateString(forIndex: indexPath.row) ?? ""
        cell.update(dateString, HabitsStore.shared.habit(habit, isTrackedIn: selectDate))
        return cell
    }

}

extension HabitDetailsViewController: UITableViewDelegate {

}
