
import UIKit

class NotesViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let createNoteButton = UIBarButtonItem(barButtonSystemItem: .compose,
                                               target: self,
                                               action: #selector(notesButtonPressed))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = createNoteButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        if Singleton.shared.value == 0 {
            tabBarController?.title = "Заметки"
        } else {
            tabBarController?.title = "Заметки(\(Singleton.shared.value))"
        }
        
    }
    
    @objc private func notesButtonPressed() {
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
