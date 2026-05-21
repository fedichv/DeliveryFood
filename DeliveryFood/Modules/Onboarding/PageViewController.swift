import UIKit

// MARK: - Models

struct PageViewControllerModel {
    var identifier = "PageViewController"
    let imageName: String
    let title: String
    let description: String
    let textButton: String
}

struct OnboardingConstants {
    static let pages: [PageViewControllerModel] = [
        PageViewControllerModel(
            imageName: "chicken-leg",
            title: "Delicious Food",
            description: "Lorem ipsum dolor sit amet, consectetur \n adipiscing elit.",
            textButton: "Next"
        ),
        PageViewControllerModel(
            imageName: "shipped",
            title: "Fast Shipping",
            description: "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Interdum rhoncus nulla.",
            textButton: "Next"
        ),
        PageViewControllerModel(
            imageName: "medal",
            title: "Certificate Food",
            description: "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Morbi ultricies mauris a id.",
            textButton: "Cool!"
        ),
    ]
}

// MARK: - Protocols

protocol PageViewControllerDelegate: AnyObject {
    func changePage(index: Int, model: PageViewControllerModel)
    func didFinishOnboarding()
}

// MARK: - PageViewController

class PageViewController: UIPageViewController {

    var rootView: UIView { view }
    weak var customDelegate: PageViewControllerDelegate?

    private var pages: [FoodPageContentViewController] = []
    private var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        setupPages()
        setInitialPage()
    }

    private func setupPages() {
        for model in OnboardingConstants.pages {
            let vc = FoodPageContentViewController()
            vc.configure(imageName: model.imageName,
                         onboardingTitle: model.title,
                         ondoardingDescription: model.description,
                         button: model.textButton)
            pages.append(vc)
        }
    }

    private func setInitialPage() {
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true)
            customDelegate?.changePage(index: currentIndex, model: OnboardingConstants.pages[currentIndex])
        }
    }

    private func goToNextPage() {
        let next = currentIndex + 1
        guard next < pages.count else { goToSignInUpVC(); return }
        setViewControllers([pages[next]], direction: .forward, animated: true)
        currentIndex = next
        customDelegate?.changePage(index: currentIndex, model: OnboardingConstants.pages[currentIndex])
    }

    private func goToSignInUpVC() {
        UserDefaultsManager.shared.set(true, forKey: .isWatchedOnboarding)
        let vc = SignInUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? FoodPageContentViewController,
              let index = pages.firstIndex(of: vc),
              index - 1 >= 0 else { return nil }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? FoodPageContentViewController,
              let index = pages.firstIndex(of: vc),
              index + 1 < pages.count else { return nil }
        return pages[index + 1]
    }
}

// MARK: - UIPageViewControllerDelegate

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard completed,
              let current = pageViewController.viewControllers?.first as? FoodPageContentViewController,
              let index = pages.firstIndex(of: current) else { return }
        currentIndex = index
        customDelegate?.changePage(index: currentIndex, model: OnboardingConstants.pages[currentIndex])
    }
}

// MARK: - FoodOnboardingViewControllerDelegate

extension PageViewController: FoodOnboardingViewControllerDelegate {
    func didFinishOnboarding() { goToSignInUpVC() }

    func tapOnNextButton() {
        if currentIndex == pages.count - 1 {
            customDelegate?.didFinishOnboarding()
        } else {
            goToNextPage()
        }
    }
}

// MARK: - FoodOnboardingViewControllerDataSource

extension PageViewController: FoodOnboardingViewControllerDataSource {
    func numberOfPageCount() -> Int { pages.count }
}
