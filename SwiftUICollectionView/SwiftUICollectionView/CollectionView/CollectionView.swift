import SwiftUI

extension CollectionView {
  typealias UIKitCollectionView = CollectionViewWithDataSource<SectionIdentifierType, ItemIdentifierType>
  typealias DataSource =  UICollectionViewDiffableDataSource<SectionIdentifierType, ItemIdentifierType>
  typealias Snapshot = NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>
  typealias UpdateCompletion = () -> Void
}

struct CollectionView<SectionIdentifierType, ItemIdentifierType>
where
SectionIdentifierType: Hashable & Sendable,
ItemIdentifierType: Hashable & Sendable {
  
  private let snapshot: Snapshot
  private let configuration: ((UICollectionView) -> Void)
  private let cellProvider: DataSource.CellProvider
  private let supplementaryViewProvider: DataSource.SupplementaryViewProvider?
  
  private let collectionViewLayout: () -> UICollectionViewLayout
  
  private(set) var collectionViewDelegate: (() -> UICollectionViewDelegate)?
  private(set) var animatingDifferences: Bool = true
  private(set) var updateCallBack: UpdateCompletion?
  
  init(snapshot: Snapshot,
       collectionViewLayout: @escaping () -> UICollectionViewLayout,
       configuration: @escaping ((UICollectionView) -> Void) = { _ in },
       cellProvider: @escaping  DataSource.CellProvider,
       supplementaryViewProvider: DataSource.SupplementaryViewProvider? = nil) {
    
    self.snapshot = snapshot
    self.configuration = configuration
    self.cellProvider = cellProvider
    self.supplementaryViewProvider = supplementaryViewProvider
    self.collectionViewLayout = collectionViewLayout
  }
}

extension CollectionView: UIViewRepresentable {
  final class Coordinator {
    var delegate: UICollectionViewDelegate?
    
    init(delegate: UICollectionViewDelegate?) {
      self.delegate = delegate
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(delegate: collectionViewDelegate?())
  }
  
  func makeUIView(context: Context) -> UIKitCollectionView {
    let collectionView = UIKitCollectionView(
      frame: .zero,
      collectionViewLayout: collectionViewLayout(),
      collectionViewConfiguration: configuration,
      cellProvider: cellProvider,
      supplementaryViewProvider: supplementaryViewProvider
    )
    
    collectionView.delegate = context.coordinator.delegate
    return collectionView
  }
  
  func updateUIView(_ uiView: UIKitCollectionView,
                    context: Context) {
    uiView.apply(
      snapshot,
      animatingDifferences: animatingDifferences,
      completion: updateCallBack
    )
  }
}

extension CollectionView {
  func animateDifferences(_ animate: Bool) -> Self {
    var selfCopy = self
    selfCopy.animatingDifferences = animate
    return selfCopy
  }
  
  func onUpdate(_ perform: (() -> Void)?) -> Self {
    var selfCopy = self
    selfCopy.updateCallBack = perform
    return selfCopy
  }
  
  func collectionViewDelegate(_ makeDelegate: @escaping (() -> UICollectionViewDelegate)) -> Self {
    var selfCopy = self
    selfCopy.collectionViewDelegate = makeDelegate
    return selfCopy
  }
}
