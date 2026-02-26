//
//  ButtonView.swift
//  Homework 18
//
//  Created by Margarita Matsonko on 26/02/2026.
//

import UIKit

final class ButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        var config = UIButton.Configuration.plain()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        config.image = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
        self.configuration = config
    }
}
