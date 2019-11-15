
import UIKit

class MainViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var arrayListWithCards: [ListWithCards] = []
    
    private var cortege = (false, false) {
        didSet {
            if self.cortege == (true, true) {
                for i in self.lists {
                    var listCard = ListWithCards(list: i.name, cards: [])
                    for j in self.cards {
                        if j.idList == i.id {
                            listCard.cards.append(j.name)
                        }
                    }
                    arrayListWithCards.append(listCard)
                    
                }
            }
            print(arrayListWithCards)
        }
    }
    private let idBoard = "2XJ1X5mg"
    private let apiToken: String = "375c9d91cf52dd50f5feb1c2b7ca76fdd2ac9f621ddaf08e3686ee1d5e7a650c"
    private let apiKey: String = "28e8753e7b1cb1c96af05f7e48fd6748"
    private var trelloCardLink: String {
        return "https://api.trello.com/1/boards/\(idBoard)/cards?fields=idList,name&key=\(apiKey)&token=\(apiToken)"
    }
    
    private var trelloListLink: String {
        return "https://api.trello.com/1/boards/\(idBoard)/lists?fields=name&key=\(apiKey)&token=\(apiToken)"
    }
    
    
    private var cards: [Card] = []
    private var lists: [List] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInsetReference = .fromContentInset

        layout.itemSize = CGSize(width: 0.5 * view.frame.width, height: 0.8 * view.frame.height)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.scrollDirection = .horizontal
        layout.footerReferenceSize = CGSize(width: 0.5 * self.view.frame.width, height: 60)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        collectionView.backgroundColor = #colorLiteral(red: 0.2951487303, green: 0.7470143437, blue: 0.4178136587, alpha: 1)
        collectionView.bounces = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TasksColumnCell.self, forCellWithReuseIdentifier: TasksColumnCell.reuseId)
        collectionView.register(CreateNewColumnCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: CreateNewColumnCell.reuseId)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "main"), tag: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true

        // MARK: GET ЗАПРОС
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url1 = URL(string: trelloCardLink)!
        let urlRequest1 = URLRequest(url: url1, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 1)
        
        
        let task1 = session.dataTask(with: urlRequest1, completionHandler: {(data, response, error)
            in
            do {
                let posts = try JSONDecoder().decode([Card].self, from: data!)
                self.cards = Array(posts)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                self.cortege.1 = true
            } catch {
                print(error)
            }
        })
        task1.resume()
        
        
        let url2 = URL(string: trelloListLink)!
        let urlRequest2 = URLRequest(url: url2, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 1)
        
        let task2 = session.dataTask(with: urlRequest2, completionHandler: {(data, response, error)
            in
            do {
                let posts = try JSONDecoder().decode([List].self, from: data!)
                self.lists = Array(posts)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                self.cortege.0 = true
            } catch {
                print(error)
            }
        })
        task2.resume()
    }

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionViewDataModel.shared.dataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TasksColumnCell.reuseId, for: indexPath) as! TasksColumnCell
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: CreateNewColumnCell.reuseId,
                                                                   for: indexPath) as! CreateNewColumnCell
        cell.layer.cornerRadius = 10
        cell.delegate = self
        
        return cell
    }
}

extension MainViewController: CreateNewColumnCellDelegate {
    func buttonDidTouch() {

        collectionView.performBatchUpdates({
            CollectionViewDataModel.shared.dataModel.append(CollectionViewDataModel.DataModel(index: CollectionViewDataModel.shared.dataModel.count))
            collectionView.insertItems(at: [IndexPath(row: CollectionViewDataModel.shared.dataModel.count - 1,
                                                      section: 0)])
        }, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0.5 * self.view.frame.width, height: 60)
    }
}

extension MainViewController: TasksColumnCellDelegate {
    func showMessage(text: String) {
        let alertController = UIAlertController(title: "Текст ячейки", message: text, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
    func getTextFromAlertController(completionHandler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "Введите содержимое карточки", message: nil, preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: nil)
        
        alertController.addAction(UIAlertAction(title: "Сохранить", style: .destructive, handler: { (_) in
            completionHandler(alertController.textFields?.first?.text ?? "")
        }))
        
        alertController.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: { (_) in
            completionHandler("")
        }))
        
        present(alertController, animated: true)
    }
}

