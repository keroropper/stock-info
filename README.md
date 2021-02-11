# README

# アプリ名
  StockApp

# 概要
  投資家のための株知識共有アプリ

# 目的
  株の知識を共有し、投資に興味を持つきっかけを作るため

# 機能一覧
  - ユーザー新規登録、ログイン機能
  - 記事の投稿機能
  - 記事投稿時、画像をプレビューする機能
  - マークダウン表記機能
  - 記事の詳細機能
  - 記事の編集機能
  - 記事の検索機能
  - 記事にコメントをつける機能
  - 記事に「いいね」を付ける機能
  - ニュース閲覧機能
  - ページネーション機能

  ### 記事投稿時、画像をプレビューする機能
  ![](https://i.gyazo.com/89c7c027f8c2c147848ed83f16bed70c.git)
  ### 記事に「いいね」を付ける機能
  ![](https://i.gyazo.com/06f28c6da52bf451a5f15dc3a92f0af8.git)
  ### ニュース閲覧機能
  ![](https://i.gyazo.com/bd9c5bc48336025ec323c8d8dc35d3e5.git)
  
# 実装予定の機能
  - 投稿画像の削除と編集ができるようにします。
  - 他の人の投稿を保存できるようにします。
  - マイページを実装し、保存した投稿を見れるようにします。

# テストアカウント
**ログイン画面に記載してあるので覚える必要はありません**
メールアドレス： test@1
パスワード： 123456
パスワード(確認用)： 123456


## usersテーブル

  | column   | type   | options                   | 
  | -------- | ------ | ------------------------- | 
  | nickname | string | null: false               | 
  | email    | string | null: false, unique: true | 
  | password | string | null: false               | 

### association

  has_many :articles
  has_many :likes
  has_many :comments

## articleテーブル

  | column  | type       | options           | 
  | ------- | ---------- | ----------------- | 
  | title   | string     | null: false       | 
  | content | text       | null: false       | 
  | user    | references | foreign_key: true | 

### association

  has_many :article_tag_relations
  has_many :tags, through: :article_tag_relations
  has_many_attached :images
  belongs_to :user
  has_many :likes
  has_many :comments

## tagテーブル

  | column  | type       | options                       | 
  | ------- | ---------- | ----------------------------- | 
  | name    | string     | null: false, uniqueness: true | 

### association

  has_many :article_tag_relations, dependent: :destroy
  has_many :articles, through: :article_tag_relations

## article_tag_relationsテーブル

  | column  | type       | options           | 
  | ------- | ---------- | ----------------- | 
  | article | references | foreign_key: true | 
  | tag     | references | foreign_key: true | 

### association

  belongs_to :article
  belongs_to :tag

## likesテーブル

  | column  | type       | options           | 
  | ------- | ---------- | ----------------- | 
  | article | references | foreign_key: true | 
  | user    | references | foreign_key: true | 

### association

  belongs_to :user
  belongs_to :article

## commentsテーブル

  | column  | type       | options           | 
  | ------- | ---------- | ----------------- | 
  | text    | text       | null: false       | 
  | article | references | foreign_key: true | 
  | user    | references | foreign_key: true | 

### association

  belongs_to :user
  belongs_to :article
