//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Kr Qqq on 12.07.2023.
//

import UIKit

protocol HabitsViewControllerDelegate: AnyObject {
    func updateProgress()
}

class HabitsViewController: UIViewController, HabitsViewControllerDelegate {

    private lazy var addBarButtonItem: UIBarButtonItem = {
        return createTabButton(imageName: "plus", selector: #selector(addbuttonPressed(_:)))
    }()
    
    private lazy var habitsCollection: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "HabitGray")
       
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.id)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.id)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItems = [addBarButtonItem]
        title = "Сегодня"
        habitsCollection.dataSource = self
        habitsCollection.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(habitsCollection)
    }
    
    func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            habitsCollection.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            habitsCollection.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            habitsCollection.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            habitsCollection.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        habitsCollection.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func updateProgress() {
        habitsCollection.reloadData()
    }
    
    // MARK: - Selectors
    
    @objc func addbuttonPressed(_ sender: UIButton) {
        let habitViewController = UINavigationController(rootViewController: HabitViewController())
        habitViewController.modalPresentationStyle = .fullScreen
        present(habitViewController, animated: true)
    }

}

extension HabitsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return HabitsStore.shared.habits.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.id, for: indexPath) as! ProgressCollectionViewCell
            cell.update()
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.id, for: indexPath) as! HabitCollectionViewCell
            cell.delegate = self
            cell.update(HabitsStore.shared.habits[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width - 16*2 //16
        switch indexPath.section {
        case 0:
            return CGSize(width: width, height: 55)
        case 1:
            return CGSize(width: width, height: 130)
        default:
            return CGSize()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: 20,
            left: 0,
            bottom: 0,
            right: 0
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            collectionView.deselectItem(at: indexPath, animated: true)
            let habitRow = HabitsStore.shared.habits[indexPath.row]
            navigationController?.pushViewController(HabitDetailsViewController(habit: habitRow), animated: true)
        default:
            return
        }

    }
}
