//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Kr Qqq on 14.07.2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    static let id = "ProgressCollectionViewCell"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        label.text = "Всё получится!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var todayProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
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
        contentView.addSubview(todayProgressView)
        contentView.addSubview(progressLabel)
    }
    
    private func tuneView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            todayProgressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            todayProgressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            todayProgressView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),

            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        ])
    }
    
    func update() {
        todayProgressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
        progressLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
    }    
}
