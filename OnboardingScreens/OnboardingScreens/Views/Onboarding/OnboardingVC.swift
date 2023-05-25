//
//  ViewController.swift
//  OnboardingScreens
//
//  Created by BerkH on 24.05.2023.
//

import UIKit

class OnboardingVC: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var pageController: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageController.currentPage = currentPage
            if currentPage == slides.count - 1 {
                btnNext.setTitle("Get Started", for: .normal)
            }else{
                btnNext.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        slides = [
            OnboardingSlide(title: "Check in baggage before flight", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: UIImage(imageLiteralResourceName: "Image1")),
            OnboardingSlide(title: "Confirm documents on the app", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: UIImage(imageLiteralResourceName: "Image2")),
            OnboardingSlide(title: "Internet connection during flight", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: UIImage(imageLiteralResourceName: "Image3"))
        
        ]
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    @IBAction func btnNextClicked(_ sender: Any) {
        if currentPage != slides.count - 1 {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }else{
            let controller = storyboard?.instantiateViewController(withIdentifier: "toHomeVC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true)
        }
        
        

    }
    
}

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCell", for: indexPath) as! OnboardingCollectionViewCell
        let currentItem = slides[indexPath.row]
        cell.slideImageView.image = currentItem.image
        cell.lblSlideTitle.text = currentItem.title
        cell.lblSlideDescription.text = currentItem.description
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}
