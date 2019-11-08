
import UIKit

class SIgnUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        
        backButton.title = "Назад"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
      
        
        view.backgroundColor = .white
        let lable = UILabel(frame: CGRect(x: 39 , y: 273, width: 324, height: 138))
        lable.font = UIFont.systemFont(ofSize: 27.0)
        lable.textAlignment = .center
        lable.lineBreakMode = .byWordWrapping
        lable.numberOfLines = 2
        lable.text = "Извините данная функция сейчас недоступна."
        lable.center = CGPoint(x: view.center.x, y: view.center.y - 100)
        view.addSubview(lable)
        
        let lable2 = UILabel(frame: CGRect(x: 16 , y: 387, width: 350, height: 84))
        lable2.font = UIFont.systemFont(ofSize: 27.0)
        lable2.textAlignment = .center
        lable2.lineBreakMode = .byWordWrapping
        lable2.numberOfLines = 2
        lable2.text = "Зарегистрируйтесь через сайт."
        lable2.center = CGPoint(x: view.center.x, y: view.center.y - 20)
        view.addSubview(lable2)
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        
    }
    

}
