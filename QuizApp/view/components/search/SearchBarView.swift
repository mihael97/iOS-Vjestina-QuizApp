//
//  SearchBarView.swift
//  QuizApp
//
//  Created by five on 26/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class SearchBarView: UITextField {
    private let searchImage = UIImage(systemName: "magnifyingglass")
    private var searchButton: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayer() {
        self.layer.cornerRadius = CGFloat(5)
        self.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
    }
    
    private func addVisiblityButton() {
        searchButton = UIButton()
        searchButton.setImage(searchImage, for: .normal)
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: -24, bottom: 5, right: 15)
        searchButton.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(15), height: CGFloat(28))
        searchButton.addTarget(self, action: #selector(self.searchButtonClicked), for: .touchUpInside)
        self.rightView = searchButton
        self.rightViewMode = .always
    }
    
    @objc
    private func searchButtonClicked(_ button: UIButton!) {
        print("A")
    }
    
    private func buildView() {
        self.backgroundColor = .systemPurple
        self.placeholder = "Type here"
        setLayer()
        addVisiblityButton()
    }
}
