import UIKit
import SnapKit

class SettingsScreen: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellIdentifier = "MyCell"
    
    let dataArray = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        if indexPath.row == 1 {
            cell.backgroundColor = .red
        }
        else if indexPath.row == 1 {
            cell.backgroundColor = .lightGray
        }
        else if indexPath.row == 1 {
            cell.backgroundColor = .blue
        }
        else {
            cell.backgroundColor = .brown
        }
        
        // Customize cell content based on the data array
        let item = dataArray[indexPath.item]
        // Configure the cell with the item data
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50) // Adjust the height as per your requirement
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Handle any additional logic based on the scroll position
    }
}

//

