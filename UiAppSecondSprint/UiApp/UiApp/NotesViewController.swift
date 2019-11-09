

import UIKit

class NotesViewController: UIViewController {
    
   var textView = UILabel(frame: CGRect(x: 124, y: 103, width: 135, height: 21))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        
        let backButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(notesButtonPressed))
        
        textView.font = UIFont.systemFont(ofSize: 17.0)
        textView.textAlignment = .center
        textView.backgroundColor = #colorLiteral(red: 0.9860597253, green: 0.9862243533, blue: 0.98603791, alpha: 1)
       
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = backButton
        self.navigationController?.navigationBar.topItem?.titleView = textView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        
        
        if Singleton.shared.value == 0 {
            textView.text = "Заметки"
        } else {
            textView.text = "Заметки(\(Singleton.shared.value))"
        }
        
  
    }
    
    @objc func notesButtonPressed () {
        navigationController?.pushViewController(CreateNoteViewController(), animated: true)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "notes"), tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
