//
//  TagCollectionViewCell.swift
//  TravelGenie
//
//  Created by 서현웅 on 2023/08/18.
//

import UIKit

protocol TagSelectionDelegate: AnyObject {
    func tagDidSelect(withText text: String, isOn: Bool)
}

class TagCollectionViewCell: UICollectionViewCell {
    static var identifier: String { return String(describing: self) }
    
    weak var delegate: TagSelectionDelegate?
    private let tagButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureSubviews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(tag: MockTag) {
        configureTagButtonText(tag: tag)
    }
    
    private func configureSubviews() {
        congirueTagButton()
    }
    
    private func congirueTagButton() {
        setButtonAction()
        tagButton.layer.cornerRadius = 24
        tagButton.layer.borderWidth = 1.0
        self.tagButton.backgroundColor = .white
        self.tagButton.layer.borderColor = UIColor.blueGrayLine.cgColor
    }
    
    private func configureTagButtonText(tag: MockTag) {
        let tagText = tag.text
        
        let defaultText = NSMutableAttributedString()
            .text(tagText, font: .bodyRegular, color: .black)
        let selectedText = NSMutableAttributedString()
            .text(tagText, font: .bodyBold, color: .primary)
        
        tagButton.setAttributedTitle(defaultText, for: .normal)
        tagButton.setAttributedTitle(selectedText, for: .selected)
    }
    
    private func setButtonAction() {
        let buttonAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.tagButton.isSelected.toggle()
            self.setButtonAttribute(sender: self.tagButton.state)
            self.notifyTagSelection(sender: self.tagButton)
        }
        
        tagButton.addAction(buttonAction, for: .touchUpInside)
    }
    
    private func setButtonAttribute(sender: UIButton.State) {
        switch sender {
        case .highlighted:
            self.tagButton.backgroundColor = .white
            self.tagButton.layer.borderColor = UIColor.blueGrayLine.cgColor
            self.tagButton.layer.borderWidth = 1
        default:
            self.tagButton.backgroundColor = .tertiary
            self.tagButton.layer.borderColor = UIColor.primary.cgColor
            self.tagButton.layer.borderWidth = 2
        }
    }
    
    private func notifyTagSelection(sender: UIButton) {
        let selectedState = UIButton.State(rawValue: 5)
        let deselectedState = UIButton.State(rawValue: 1)
        
        guard let tagText = sender.titleLabel?.text else { return }
        
        switch sender.state {
        case selectedState:
            delegate?.tagDidSelect(withText: tagText, isOn: true)
        case deselectedState:
            delegate?.tagDidSelect(withText: tagText, isOn: false)
        default:
            break
        }
    }
    
    private func configureLayout() {
        contentView.addSubview(tagButton)
        
        tagButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tagButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tagButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
