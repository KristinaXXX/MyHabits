//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Kr Qqq on 14.07.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    static let id = "HabitCollectionViewCell"
    private var habit: Habit!
    weak var delegate: HabitsViewControllerDelegate?
    
    private lazy var nameLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var colorView: UIImageView = { [unowned self] in
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.layer.borderWidth = 3
        
        let tapView = UITapGestureRecognizer(target: self, action: #selector(didTapColorView))
        view.addGestureRecognizer(tapView)
        
        return view
    }()
    
    private lazy var dateLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var counterLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubviews()
        setupConstraints()
        tuneView()
    }
    
    private func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(colorView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(counterLabel)
    }
    
    private func tuneView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.trailingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: -30),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            colorView.widthAnchor.constraint(equalToConstant: 40),
            colorView.heightAnchor.constraint(equalToConstant: 40),
            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            colorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            counterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            counterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])

    }
    
    func update(_ habit: Habit) {
        self.habit = habit
        nameLabel.text = habit.name
        dateLabel.text = habit.dateString
        
        nameLabel.textColor = habit.color
        counterLabel.text = "Счётчик: \(habit.trackDates.count)"
        
        if (habit.isAlreadyTakenToday) {
            colorView.image = UIImage(systemName: "checkmark.circle.fill")
            colorView.tintColor = habit.color
        } else {
            colorView.image = UIImage()
            colorView.backgroundColor = .white
        }
        colorView.layer.borderColor = habit.color.cgColor
    }
    
    @objc private func didTapColorView() {
        HabitsStore.shared.track(habit)
        self.update(habit)
        delegate?.updateProgress()
    }
}
