//
//  CreateNoteViewController.swift
//  UiApp
//
//  Created by Artem Esolnyak on 08.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import UIKit



class CreateNoteViewController: UIViewController {
    
    
    var object = Singleton.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let textView = UITextView(frame: CGRect(x: 20 , y: 80, width: 334, height: 446))
        textView.center = view.center
        textView.backgroundColor = #colorLiteral(red: 0.9589001536, green: 0.9590606093, blue: 0.9588790536, alpha: 1)
        view.addSubview(textView)
        
        let save = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem = save
        // Do any additional setup after loading the view.
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden  = false
    }
    @objc func saveButtonPressed() -> Int{
        
        object.value += 1
        
        return object.value
        
    }
    
 

}
