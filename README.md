# T-farm

自分で育てた農作物を投稿し合うSNSサイトです

<img width="1417" alt="スクリーンショット 2020-02-16 19 34 39" src="https://user-images.githubusercontent.com/48900966/74603763-43565980-50fa-11ea-81d8-e8970059cf71.png">


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
  - ACM
  - SES(認証待ち)


# 機能一覧
- ユーザ登録(devise)
  - 画像アップロード
    - carrierwave, S3
- 投稿機能
  - 画像アップロード
    - carrierwave, S3
- いいね機能(Ajax)
- コメント機能(Ajax)
- いいねが多い投稿表示機能
- 投稿のページネーション機能(kaminari)


# テスト
- 単体テスト
- 統合テスト
  - selenium
