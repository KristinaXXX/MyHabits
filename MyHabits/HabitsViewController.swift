//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Kr Qqq on 12.07.2023.
//

import UIKit

class HabitsViewController: UIViewController {

    private lazy var addBarButtonItem: UIBarButtonItem = {
        return createTabButton(imageName: "plus", selector: #selector(addbuttonPressed(_:)))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationItem.rightBarButtonItems = [addBarButtonItem]
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    // MARK: - Selectors
    
    @objc func addbuttonPressed(_ sender: UIButton) {
       
        let habitViewController = HabitViewController()

//        habitViewController.modalTransitionStyle = .coverVertical
//        habitViewController.modalPresentationStyle = .fullScreen
//        present(habitViewController, animated: true)
        
        navigationController?.pushViewController(habitViewController, animated: true)
    }

}
