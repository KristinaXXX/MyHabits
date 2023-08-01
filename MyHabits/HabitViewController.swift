//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Kr Qqq on 12.07.2023.
//

import UIKit
import Foundation

class HabitViewController: UIViewController {
    
    private var habit: Habit?
    var closureClose: (() -> Void)?

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        return contentView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        label.text = "НАЗВАНИЕ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = UIColor(named: "HabitBlue")
        textField.delegate = self
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        return textField
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        label.text = "ЦВЕТ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let tapView = UITapGestureRecognizer(target: self, action: #selector(didTapColorView))
        view.addGestureRecognizer(tapView)
        
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        label.text = "ВРЕМЯ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        label.text = "Каждый день в"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.date = NSDate() as Date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private lazy var saveBarButtonItem: UIBarButtonItem = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        button.setTitleColor(UIColor(named: "HabitPurple"), for: .normal)
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var cancelBarButtonItem: UIBarButtonItem = {
        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)
        button.setTitleColor(UIColor(named: "HabitPurple"), for: .normal)
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var deleteHabbit: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.addTarget(self, action: #selector(deleteButtonPressed(_:)), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
        nameTextField.text = habit.name
        timeDatePicker.date = habit.date
        colorView.backgroundColor = habit.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "HabitGray")
        if habit == nil {
            title = "Создать"
        } else {
            title = "Править"
        }
        navigationItem.rightBarButtonItems = [saveBarButtonItem]
        navigationItem.leftBarButtonItems = [cancelBarButtonItem]
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func addSubviews() {
        view.addSubview(contentView)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(colorLabel)
        contentView.addSubview(colorView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeDatePicker)
        
        if habit != nil {
            contentView.addSubview(deleteHabbit)
        }
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
      
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),

            colorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            colorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),

            colorView.widthAnchor.constraint(equalToConstant: 30),
            colorView.heightAnchor.constraint(equalToConstant: 30),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            colorView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10),

            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 20),

            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),

            timeDatePicker.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 8),
            timeDatePicker.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            timeDatePicker.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        if habit != nil {
            NSLayoutConstraint.activate([
                deleteHabbit.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
                deleteHabbit.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ])
        }
    }
    
    // MARK: - Selectors
    
    @objc private func saveButtonPressed(_ sender: UIButton) {
        
        guard let nameText = nameTextField.text, !nameText.isEmpty else {
            return
        }
            
        if habit == nil {
            let newHabit = Habit(name: nameText, date: timeDatePicker.date, color: colorView.backgroundColor!)
            let store = HabitsStore.shared
            store.habits.append(newHabit)
        }
        else {
            habit!.name = nameText
            habit!.date = timeDatePicker.date
            habit!.color = colorView.backgroundColor!
        }
        HabitsStore.shared.save()
        self.dismiss(animated: true)
  
    }
    
    @objc private func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc private func didTapColorView() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = colorView.backgroundColor ?? .black
        colorPicker.title = "Цвет"
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .automatic
        self.present(colorPicker, animated: true)
    }
    
    @objc private func deleteButtonPressed(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(habit!.name)\"?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Отмена", comment: "Default action"), style: .cancel, handler: { _ in }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Удалить", comment: "Default action"), style: .destructive, handler: { [self]_ in
            HabitsStore.shared.deleteHabit(self.habit!)
            self.dismiss(animated: true, completion: closureClose)
        }))
        self.present(alert, animated: true)
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ colorPickerViewController: UIColorPickerViewController, didSelect: UIColor, continuously: Bool) {
        colorView.backgroundColor = didSelect
    }
}

extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
