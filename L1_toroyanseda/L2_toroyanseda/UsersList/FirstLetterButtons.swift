//
//  FirstLetterButtons.swift
//  L2_toroyanseda
//
//  Created by Seda on 15/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit


enum Letter: Int {
    case A,B,G,I,M,N,P,S,Z

    static let AllLetters: [Letter] = [A,B,G,I,M,N,P,S,Z]
    
    var title: String {
        switch self {
        case .A: return "A"
        case .B: return "B"
        case .G: return "G"
        case .I: return "I"
        case .M: return "M"
        case .N: return "N"
        case .P: return "P"
        case .S: return "S"
        case .Z: return "Z"
       
        }
    }
}
class FirstLetterButtons: UIControl {
    
    
    var tableView:UITableView!
    var selectedLetter: Letter? = nil {
        didSet {
           
            self.updateSelectedLetter()
            self.sendActions(for: .valueChanged)
        }
    }
    
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView() {
        for letter in Letter.AllLetters {
            let button = UIButton(type: .system)
            button.setTitle(letter.title, for: .normal)
            button.setTitleColor(UIColor.init(red: 0.2, green: 0.7, blue: 9, alpha: 1), for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectLetter(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
        stackView = UIStackView(arrangedSubviews: self.buttons)
        
        self.addSubview(stackView)
        
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    private func updateSelectedLetter() {
        for (index, button) in self.buttons.enumerated() {
            guard let letter = Letter(rawValue: index) else {
                continue
                
            }
            button.isSelected = letter == self.selectedLetter
        }
    }
    
    @objc private func selectLetter(_ sender: UIButton) {
        
        guard var index = self.buttons.index(of: sender), let letter = Letter(rawValue: index) else {
            return
            
        }
       
        self.selectedLetter = letter
        let indexPath = IndexPath(row: 0, section: index)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
 
    
}


        


