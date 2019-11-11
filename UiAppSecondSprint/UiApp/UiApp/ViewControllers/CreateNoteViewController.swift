//
//  CreateNoteViewController.swift
//  UiApp
//
//  Created by Artem Esolnyak on 08.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import UIKit

class CreateNoteViewController: UIViewController {
            
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let textView = UITextView()
        textView.backgroundColor = #colorLiteral(red: 0.9589001536, green: 0.9590606093, blue: 0.9588790536, alpha: 1)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        textView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
        textView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.layoutIfNeeded()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonPressed))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc private func saveButtonPressed() {
        Singleton.shared.value += 1
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
