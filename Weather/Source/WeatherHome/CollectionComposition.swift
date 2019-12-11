//
//  WeatherCollectionCompositionalLayout.swift
//  Weather
//
//  Created by Arslan Faisal on 01/12/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import UIKit

struct CollectionComposition {
    
    func headerViewSupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerViewItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(WeatherCollectionFlowLayOut.WeatherCollectionSection.sectionHeaderHeight)),elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
        headerViewItem.pinToVisibleBounds = false
        return headerViewItem
    }
    func setupCollectionLayout() -> UICollectionViewLayout {
           
           let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension:.fractionalHeight(1.0)))
           item.contentInsets = NSDirectionalEdgeInsets(top: WeatherCollectionFlowLayOut.WeatherCollectionItem.itemTopSpace,leading: WeatherCollectionFlowLayOut.WeatherCollectionItem.itemLeadingSpace,bottom: WeatherCollectionFlowLayOut.WeatherCollectionItem.itemBottomSpace,trailing: WeatherCollectionFlowLayOut.WeatherCollectionItem.itemTrailingSpace)

           let group = NSCollectionLayoutGroup.vertical(
               layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(WeatherCollectionFlowLayOut.WeatherCollectionItem.itemWidth),heightDimension: .absolute(WeatherCollectionFlowLayOut.WeatherCollectionItem.itemHeight)),subitem: item,count: 1)

           let section = NSCollectionLayoutSection(group: group)
           section.contentInsets = NSDirectionalEdgeInsets(top: WeatherCollectionFlowLayOut.WeatherCollectionSection.sectionTopSpace,leading: WeatherCollectionFlowLayOut.WeatherCollectionSection.sectionLeadingSpace,bottom: WeatherCollectionFlowLayOut.WeatherCollectionSection.sectionBottomSpace,trailing: WeatherCollectionFlowLayOut.WeatherCollectionSection.sectionTrailingSpace)

           section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
           section.boundarySupplementaryItems = [headerViewSupplementaryItem()]

           let layout = UICollectionViewCompositionalLayout(section: section)
           return layout
       }
}
