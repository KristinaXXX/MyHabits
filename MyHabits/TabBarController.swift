//
//  TabBarController.swift
//  MyHabits
//
//  Created by Kr Qqq on 12.07.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let infoViewController = UINavigationController.init(rootViewController: InfoViewController())
        let habitsViewController = UINavigationController(rootViewController: HabitsViewController())
        
        viewControllers = [habitsViewController, infoViewController]
        
        habitsViewController.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        infoViewController.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        
        tabBar.backgroundColor = UIColor(named: "HabitGray")
    }

}
