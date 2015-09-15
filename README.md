# (Swift) KRReversibleView v1.0
KRReversibleViewは，その名の通り裏表のあるビューを作成し，イベントによって反転します．
裏表のそれぞれのビューを作成するだけで，簡単に実現することができます．

## 特徴
### シンプルな記法
反転する方向，反転のアニメーションを一行で記述できます．

### 反転の方向 (RotateDirection)
反転の方向は，
- 上から下 ` ROTATE_TB `
- 下から上 ` ROTATE_BT `
- 右から左 ` ROTATE_RL `
- 左から右 ` ROTATE_LR `

の４種類を用意しています.

### StoryBoardでの初期表示ビューの設定
KRReversibleViewは，StoryBoard上で初期表示の設定(表か裏か)の設定ができます．


## 使い方

` KRReversibleView.swift ` をプロジェクトに追加して使用してください．

### ビューのセット
```
self.reversibleView.setViews(frontView: v1, backView: v2)
```

### ビューの反転
```
self.reversibleView.makeViewReversed(duration: 1.0, rotate: .ROTATE_BT)
self.reversibleView.makeViewReversed(duration: 1.0)
self.reversibleView.makeViewReversed(rotate: .ROTATE_BT)
```
