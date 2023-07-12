//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Kr Qqq on 12.07.2023.
//

import UIKit
import Foundation

class HabitViewController: UIViewController {
    
    static var habit: Habit!

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        return contentView
    }()
    
    private lazy var nameLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        label.text = "НАЗВАНИЕ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameTextField: UITextField = { [unowned self] in
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = UIColor(named: "HabitBlue")
        return textField
    }()
    
    private lazy var colorLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        label.text = "ЦВЕТ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var colorView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let tapView = UITapGestureRecognizer(target: self, action: #selector(didTapColorView))
        view.addGestureRecognizer(tapView)
        
        return view
    }()
    
    private lazy var timeLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        label.text = "ВРЕМЯ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var saveBarButtonItem: UIBarButtonItem = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(savebuttonPressed(_:)), for: .touchUpInside)
        button.setTitleColor(UIColor(named: "HabitPurple"), for: .normal)
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var cancelBarButtonItem: UIBarButtonItem = {
        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.addTarget(self, action: #selector(cancelbuttonPressed(_:)), for: .touchUpInside)
        button.setTitleColor(UIColor(named: "HabitPurple"), for: .normal)
        return UIBarButtonItem(customView: button)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "HabitGray")
        if Self.habit == nil {
            title = "Создать"
        } else {
            title = "Править"
        }
        navigationItem.rightBarButtonItems = [saveBarButtonItem]
        navigationItem.leftBarButtonItems = [cancelBarButtonItem]
        
    }
    
    private func addSubviews() {
        view.addSubview(contentView)
        //contentView.addSubview(stackSettings)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(colorLabel)
        contentView.addSubview(colorView)
        contentView.addSubview(timeLabel)

        
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])

        
        NSLayoutConstraint.activate([
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            colorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            colorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            colorView.widthAnchor.constraint(equalToConstant: 30),
            colorView.heightAnchor.constraint(equalToConstant: 30),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            colorView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 20),
        ])
        
    }
    
    // MARK: - Selectors
    
    @objc func savebuttonPressed(_ sender: UIButton) {

    }
    
    @objc func cancelbuttonPressed(_ sender: UIButton) {
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

}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ colorPickerViewController: UIColorPickerViewController, didSelect: UIColor, continuously: Bool) {
        colorView.backgroundColor = didSelect
    }
}
