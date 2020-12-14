
import Foundation
import SDWebImage

protocol HomeViewModelProtocol {
    func getCategoriesCount() -> Int
    func configure(for index: Int) -> MainCategoriesData
    func mainCategoriesData()
    func didSelectItem(item: Int)
    func downloadImage(for Index: Int, completion: @escaping (UIImage?) -> Void)
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
    
    func downloadImage(for Index: Int, completion: @escaping (UIImage?) -> Void) {
        view?.showLoader()
        SDWebImageManager.shared.loadImage(with: URL(string: categoriesData[Index].image), options: .highPriority, progress: nil) {[weak self] (image, _, error, _, _, _) in
            if let error = error {
                print(error.localizedDescription)
            } else if let image = image {
                completion(image)
            }
            self?.view?.hideLoader()
        }
    }
    
    func getCategoriesCount() -> Int {
        return categoriesData.count
    }
    
    func configure(for index: Int) -> MainCategoriesData {
        return categoriesData[index]
    }
    
    func didSelectItem(item: Int) {
        let categoryID = categoriesData[item].id
        if categoryID == 4 {
            print(categoryID)
        } else {
            self.view?.goToTabBar(with: categoryID)
        }
    }
    
    
}
