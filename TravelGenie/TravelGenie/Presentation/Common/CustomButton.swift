//
//  CustomButton.swift
//  TravelGenie
//
//  Created by summercat on 2023/09/07.
//

import UIKit

final class CustomButton: UIButton {

    // MARK: Lifecycle
    
    init() {
        super.init(frame: .zero)
        clipsToBounds = true
        backgroundColor = .clear
        adjustsImageWhenHighlighted = false
        layer.opacity = isEnabled ? 1 : 0.2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal
    
    func size(_ size: CGFloat) -> CustomButton {
        configureLayout(with: size)
        
        return self
    }
    
    func cornerRadius(_ cornerRadius: CGFloat) -> CustomButton {
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        
        return self
    }
    
    func backgroundColor(normal: UIColor, selected: UIColor) -> CustomButton {
        backgroundColor = isSelected ? selected : normal
        
        return self
    }
    
    func tintColor(color: UIColor) -> CustomButton {
        imageView?.tintColor = color
        
        return self
    }
    
    func border(
        normalColor: UIColor,
        normalWidth: CGFloat,
        selectedColor: UIColor,
        selectedWidth: CGFloat)
        -> CustomButton
    {
        layer.borderColor = isSelected ? selectedColor.cgColor : normalColor.cgColor
        layer.borderWidth = isSelected ? selectedWidth : normalWidth
        
        return self
    }
    
    func buttonTextNormal(_ text: String, font: Font, color: UIColor) {
        let attributedText = NSMutableAttributedString()
            .text(text, font: font, color: color)
        setAttributedTitle(attributedText, for: .normal)
    }
    
    func buttonTextSelected(_ text: String, font: Font, color: UIColor) {
        let attributedText = NSMutableAttributedString()
            .text(text, font: font, color: color)
        setAttributedTitle(attributedText, for: .selected)
    }
    
    func assetIconImage(name: String, size: CGFloat) -> CustomButton {
        let image = UIImage(named: name)?
            .resize(width: size, height: size)
            .withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)
        
        return self
    }
    
    func systemIconImage(name: String, size: CGFloat) -> CustomButton {
        let image = UIImage(systemName: name)?
            .resize(width: size, height: size)
            .withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)
        
        return self
    }
    
    // MARK: Private
    
    private func configureLayout(with size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size),
        ])
    }
}
