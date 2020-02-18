# T-farm

自分で育てた農作物を投稿し合うSNSサイトです

<img width="1404" alt="スクリーンショット 2020-02-16 22 09 38" src="https://user-images.githubusercontent.com/48900966/74605196-2bd29d00-5109-11ea-9ca8-db53f7982970.png">

市場に出せない農作物も売買できるサイトに進化できるよう意識して作成しました。

# リンク
https://www.t-farm.tk/

現在停止中です。。。

ログインページの簡単ログインボタンから テストユーザ としてログイン可能です

# クラウドアーキテクト
<img width="988" alt="スクリーンショット 2020-02-17 22 00 24" src="https://user-images.githubusercontent.com/48900966/74656181-fa250900-51d0-11ea-80af-6e9ee0c14e2e.png">


# 使用技術
- Ruby 2.6.1
- Ruby on Rails 5.4.2
- MySQL 8.0.16
- Nginx 1.17
- Docker
- CircleCI
- AWS
  - VPC
  - ECS
    - EC2
  - ECR
  - ALB
  - RDS
  - S3
  - ACM
  - Route 53(ドメインはawsではないです)
  - SES
  -CloudWatch

# 機能一覧
- ユーザ登録(devise)
  - 画像アップロード
    - carrierwave
- 投稿機能
  - 画像アップロード
    - carrierwave
- いいね機能(Ajax)
- コメント機能(Ajax)
- いいねが多い投稿表示機能
- 投稿のページネーション機能(kaminari)

# テスト
- 単体テスト
- 統合テスト
  - selenium
  
# 見ていただきたい部分
バックエンド部分を特に見ていただきたいです。<br>
開発環境は**docker**を使用し、**AWSのECR/ECS**にてコンテナ管理して本番環境を構築しています。<br>
テスト環境では**CircleCI**を使用しています。一部**selenium**を使用しながらテストしています。テストが全て通れば自動デプロイする流れ**CI/CDパイプライン**を構築しています。<br>

# CircleCI/CD
RSpecテスト通過 → ECR push → aws ecsコマンドでタスクの更新とサービスの更新をしています。

今回のworkflowsです。
<img width="1354" alt="スクリーンショット 2020-02-17 19 20 11" src="https://user-images.githubusercontent.com/48900966/74645116-ae676500-51ba-11ea-83e9-5f0368e5dfae.png">

# GitHub
初めの方はまだ使い慣れてなく、masterブランチで作業してしまっていました。
<br>後半あたりから、機能別で作業するよう意識しました。

# 改善点
- レスポンシズ未対応
- 画像の読み込みが遅い
- メールアドレスの認証系

# さらに、、
去年の夏あたり機械学習にハマり、農作物の写真を機械学習も用いてカテゴリ(果実類等)分できたら面白いと思い勉強しておりました(^^;
<br>pythonで機械学習モデルをAPI化して、このアプリからJSON経由で呼び出したいと考えています
- 機械学習に関して
  <br>去年の6月あたりから11月あたりにかけて、udemy・coursera・オライリー等を用いて学習しておりました。次の3月にg検定を受ける予定です。

