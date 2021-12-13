//
//  ContainerView.swift
//  AdaptivePlusQAApp
//
//  Created by Alpamys Duimagambetov on 14.04.2021.
//

import AdaptivePlus
import UIKit

final class ContainerView: UIView {
    
    // MARK: - Callbacks
    
    var removed: VoidCallback?
        
    // MARK: - UI
    
    private let label = UILabel()
    
    private let button: UIButton = {
        let button = UIButton()
         
        button.setTitle("REMOVE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(removeTouched), for: .touchUpInside)
        return button
    }()

    var apView: APView
    
    // MARK: - Life cycle

    init(publicationPageKey: String) {
        apView = APView(publicationPageKey: publicationPageKey)
        super.init(frame: .zero)
        self.label.text = publicationPageKey
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private functions

private extension ContainerView {
    func setup() {
        [label, button, apView].forEach { addSubview($0) }
        makeConstraints()
    }
    
    func makeConstraints() {
        label.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(40)
        }
        button.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
            $0.left.equalTo(label.snp.right).offset(16)
        }
        apView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
}

// MARK: - Actions

private extension ContainerView {
    @objc func removeTouched() {
        removed?()
    }
}
