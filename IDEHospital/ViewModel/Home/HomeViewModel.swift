
import Foundation
import SDWebImage

protocol HomeViewModelProtocol {
    func mainCategoriesData()
    func getCategoriesCount() -> Int
    func getCategoryData(for index: Int) -> MainCategoriesData
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
    
    func getCategoryData(for index: Int) -> MainCategoriesData {
        return categoriesData[index]
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
