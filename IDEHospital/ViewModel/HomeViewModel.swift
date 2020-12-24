
import Foundation
import SDWebImage

protocol HomeViewModelProtocol {
    func getCategoriesCount() -> Int
    func getCategoryData(for indexPath: IndexPath)
    func mainCategoriesData()
    func didSelectItem(item: Int)
}

class HomeViewModel {
    
    //MARK:- Properties
    private weak var view: HomeVCProtocol?
    private var categoriesData = [MainCategoriesData]()
    
    //MARK:- init
    init(view: HomeVCProtocol) {
        self.view = view
    }
}

//MARK:- Private Methods
extension HomeViewModel {
    private func downloadImage(for Index: Int, completion: @escaping (UIImage?) -> Void) {
        view?.showLoader()
        SDWebImageManager.shared.loadImage(with: URL(string: categoriesData[Index].image), options: .highPriority, progress: nil) { [weak self] (image, _, error, _, _, _) in
            if let error = error {
                print(error.localizedDescription)
            } else if let image = image {
                completion(image)
            }
            self?.view?.hideLoader()
        }
    }
}

//MARK:- HomeViewModel Protocol
extension HomeViewModel: HomeViewModelProtocol {
    func mainCategoriesData() {
        view?.showLoader()
        APIManager.mainCategories { [weak self] (result) in
            switch result {
            case .success(let response):
                let data = response.data
                self?.categoriesData = data
                DispatchQueue.main.async {
                    self?.view?.reloadCollectionView()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.view?.hideLoader()
        }
    }
    
    func getCategoriesCount() -> Int {
        return categoriesData.count
    }
    
    func getCategoryData(for indexPath: IndexPath) {
        downloadImage(for: indexPath.row) { [weak self] (image) in
            guard let self = self else {return}
            if let image = image {
                self.view?.configureCell(for: indexPath, categoryData: self.categoriesData[indexPath.row], image: image)
            }
        }
    }
    
    func didSelectItem(item: Int) {
        let categoryID = categoriesData[item].id
        switch categoryID {
        case 4:
            self.view?.goToHomeNurse()
        default:
            self.view?.goToTabBar(with: categoryID)
        }
    }
}
