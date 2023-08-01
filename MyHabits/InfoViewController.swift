//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Kr Qqq on 12.07.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var infoTextView: UITextView = {
        let textView = UITextView()
        
        if let rtfPath = Bundle.main.url(forResource: "InfoText", withExtension: "rtf") {
            do {
                let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: rtfPath, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                textView.attributedText = attributedStringWithRtf
            } catch let error {
                print("Got an error \(error)")
            }
        }
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = true
        textView.isEditable = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        self.infoTextView.setContentOffset(.zero, animated: false)
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "HabitGray")
        title = "Информация"
        navigationController?.navigationBar.backgroundColor = UIColor(named: "HabitGray")
    }
    
    func addSubviews() {
        view.addSubview(infoTextView)
    }
    
    func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            infoTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            infoTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            infoTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            infoTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
