
import Foundation

protocol HomeViewModelProtocol {
    func getCategoriesCount() -> Int
    func configure(for index: Int) -> MainCategoriesData
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

//MARK:- HomeViewModel Protocol
extension HomeViewModel: HomeViewModelProtocol {
    func mainCategoriesData() {
        view?.showLoader()
        APIManager.mainCategories { [weak self] (result) in
            switch result {
            case .success(let response):
                let data = response.data
                self?.categoriesData = data
                if let homeNurse = self?.categoriesData.first(where: {$0.id == 4}) {
                    self?.categoriesData.remove(at: 3)
                    self?.categoriesData.insert(homeNurse, at: 2)
                }
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
