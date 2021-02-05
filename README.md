# README

# アプリ名
  StockApp

# 概要
  Stockappは株の知識に関する情報共有アプリです。  
  株に関するニュースを閲覧できたり、株についての知見を投稿、閲覧することができます。

# 目的
  株の知識を共有し、投資に興味を持つきっかけを作るため

# 投稿
  投稿は、
  - タイトル
  - タグ
  - 画像
  - 本文  
  について入力できます。

# 検索
  キーワードを入力し、検索ができます。  
  キーワードはタイトル、タグ、本文のいずれかに含まれていれば結果が表示されます。

# ニュース
  画面左部のニュースは、タイトルをクリックするとニュースサイトに遷移します。  

# 実装予定の機能
  - 投稿画像の削除と編集ができるようにします。
  - 他の人の投稿を保存できるようにします。
  - マイページを実装し、保存した投稿を見れるようにします。


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