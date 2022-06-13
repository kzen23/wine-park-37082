# アプリケーション名
WinePark37082

# アプリケーション概要
好きなワインについての  
記事投稿、コミュニケーション、  
情報共有ができる  
アプリケーション

# URL
https://wine-park-37082.herokuapp.com/

# テスト用アカウント
・Basic認証パスワード： 2222
・Basic認証ID： admin  
・メールアドレス1： test@com  
・パスワード1： ttttt1  
・メールアドレス2: test2@com  
・パスワード2： ttttt2

# 利用方法

## ワイン記事新規投稿
1.トップページ(一覧ページ)の  
ヘッダーからユーザー新規登録を  
行います(20歳未満は登録できないので注意です)  

2.ヘッダーの投稿するのリンクをクリックします  

3.必須項目を埋めた後、新規投稿するボタンをクリックします

## ワイン記事編集
1.ログインしている状態でトップページ(一覧ページ)のワイン記事をクリックします  

2.詳細ページ内の右側に編集するのリンクがあるのでそれをクリックします  

3.編集したい項目を編集し、更新するボタンをクリックします

## ワイン記事削除
1.ログインしている状態でトップページ(一覧ページ)のワイン記事をクリックします  

2.詳細ページ内の右側に削除するのリンクがあるのでそれをクリックします

# マイページ機能
1.ログインしている状態でヘッダー部分の自分のニックネームをクリックします  

2.詳細ページ内に私の投稿一覧というリンクがありますのでそちらをクリックします  

3.詳細ページ内で投稿されたコメントのユーザー名をクリックします

## コメント新規投稿
1.ログインしている状態でトップページ(一覧ページ)のワイン記事をクリックします  

2.詳細ページ内の右下側にコメントするのリンクがあるのでそれをクリックします  

3.コメントしたい内容を入力して、コメントするボタンをクリックします  

＊Herokuでデプロイしているため、Herokuの仕様により本番環境にアクセス頂いた際に画像リンクが切れている可能性がございます

## コメント編集
1.ログインしている状態でトップページ(一覧ページ)のワイン記事をクリックします  

2.詳細ページ内のあなたへのコメント一覧の中の過去のコメントの横に編集とあるのでクリックします  

3.コメントを編集して、更新するボタンをクリックします

## コメント削除
1.ログインしている状態でトップページ(一覧ページ)のワイン記事をクリックします  

2.詳細ページ内のあなたへのコメント一覧の中の過去のコメントの横に削除とあるのでクリックします

## フォロー・フォロワー機能
1.ログインしている状態でトップページ(一覧ページ)のワイン記事をクリックします  

2.詳細ページ内の右下側にフォローするのリンクがあるのでそれをクリックします  

3.フォローを外したい時は、フォローをやめるのリンクがあるのでそれをクリックします

# アプリケーションを作成した背景
ワイン記事の投稿を通して、  
様々なお店の様々なワインの情報  
が共有出来、コミュニケーション  
もとれるアプリがあったら、と  
思い、作成しました。

# 洗い出した要件
https://docs.google.com/spreadsheets/d/1jxrilCaK4NWmp1R09JPmOzN_9H1GRmtDmRkh4JzJlDc/edit#gid=982722306


# 実装した機能についての画像やGIFおよびその説明

## ユーザー管理機能(新規登録・ログイン)

### 新規登録

・新規登録をしましょう!
[![Image from Gyazo](https://i.gyazo.com/54ed1af662139f428e58fbbf65f24e69.gif)](https://gyazo.com/54ed1af662139f428e58fbbf65f24e69)
・フォームの必須項目を入力して新規登録しましょう。
[![Image from Gyazo](https://i.gyazo.com/db4837b418ba0d69bdbc78c631b099cd.gif)](https://gyazo.com/db4837b418ba0d69bdbc78c631b099cd)
・WinePark37082へようこそ！
[![Image from Gyazo](https://i.gyazo.com/49b62098ffdae90385457be62fb65295.jpg)](https://gyazo.com/49b62098ffdae90385457be62fb65295)
・20歳未満のユーザーはWinePark37082にユーザー登録できません。
[![Image from Gyazo](https://i.gyazo.com/dac0ee93bd209c90a574023075b3b40e.gif)](https://gyazo.com/dac0ee93bd209c90a574023075b3b40e)
・入力に失敗した時は、ページにとどまり、エラーメッセージが表示されます。
[![Image from Gyazo](https://i.gyazo.com/c084f973ffebd38ef22d1e610398090c.gif)](https://gyazo.com/c084f973ffebd38ef22d1e610398090c)

### ログイン
・ログインしましょう！
[![Image from Gyazo](https://i.gyazo.com/dc57469fdcd555162bfb89d5b952834c.gif)](https://gyazo.com/dc57469fdcd555162bfb89d5b952834c)
・EmailとPassWordを入力して認証が成功するとログインできます。ログインできました。
[![Image from Gyazo](https://i.gyazo.com/bc14e4348fbd4509c6ee42777cd63d4b.gif)](https://gyazo.com/bc14e4348fbd4509c6ee42777cd63d4b)
・認証に失敗した時は、エラーメッセージが表示されます。
[![Image from Gyazo](https://i.gyazo.com/2a3c58ae6ff92310565b13b3ce422f03.gif)](https://gyazo.com/2a3c58ae6ff92310565b13b3ce422f03)

## ワイン記事管理機能

### ワイン記事新規投稿

・ワイン記事を投稿してみましょう。
[![Image from Gyazo](https://i.gyazo.com/72af82f46ff21f2573489e163649779b.gif)](https://gyazo.com/72af82f46ff21f2573489e163649779b)
・フォームの必須項目を埋めて、新規投稿するをクリックしましょう。投稿完了です。
[![Image from Gyazo](https://i.gyazo.com/596562fd3682907849ed849f86dc399d.gif)](https://gyazo.com/596562fd3682907849ed849f86dc399d)
・入力に失敗してもエラーメッセージが出ます。UTF8に対応していない絵文字を使うとエラーが出ます。
[![Image from Gyazo](https://i.gyazo.com/43852856c61f708a47cc71045ca59f97.gif)](https://gyazo.com/43852856c61f708a47cc71045ca59f97)

### ワイン記事編集

・投稿したワイン記事を編集してみましょう！
[![Image from Gyazo](https://i.gyazo.com/c6f05a29c1f7a7eacd172d44cc7b3ff0.gif)](https://gyazo.com/c6f05a29c1f7a7eacd172d44cc7b3ff0)
・編集したい内容を入力して更新するボタンをクリックしましょう。編集完了です。
[![Image from Gyazo](https://i.gyazo.com/c567467c61c4cafd038bb9078c5cd679.gif)](https://gyazo.com/c567467c61c4cafd038bb9078c5cd679)
[![Image from Gyazo](https://i.gyazo.com/2e5ae08d6c7e3d646e41c7bf3668dbff.gif)](https://gyazo.com/2e5ae08d6c7e3d646e41c7bf3668dbff)
・編集ができるのは、記事を作成した本人のみです。
[![Image from Gyazo](https://i.gyazo.com/8edfb78ea88ab1ee8b90461e2a0d6f6c.gif)](https://gyazo.com/8edfb78ea88ab1ee8b90461e2a0d6f6c)

### ワイン記事詳細

・気になるワイン記事をクリックすると記事の詳細やその記事へのコメントを確認できます。
[![Image from Gyazo](https://i.gyazo.com/d87c63f4567cd592fd89ce606f8bcfc8.gif)](https://gyazo.com/d87c63f4567cd592fd89ce606f8bcfc8)

### ワイン記事削除

・投稿したワイン記事を削除してみましょう！記事が削除されました。
[![Image from Gyazo](https://i.gyazo.com/2f1077c6945cf38b499643aba4e31706.gif)](https://gyazo.com/2f1077c6945cf38b499643aba4e31706)
・削除ができるのは、記事を作成した本人のみです。
[![Image from Gyazo](https://i.gyazo.com/36139fda39424f029fb66e7315ccf59f.gif)](https://gyazo.com/36139fda39424f029fb66e7315ccf59f)

### マイページ

・ヘッダー右側のニックネームのリンクをクリックすると自身が行なった投稿一覧が確認できます。
[![Image from Gyazo](https://i.gyazo.com/6c7a86597e75f11d054f3c55a5854067.gif)](https://gyazo.com/6c7a86597e75f11d054f3c55a5854067)
・詳細ページの私の投稿一覧のリンクをクリックすると記事を作成したユーザーの投稿一覧が確認できます。
[![Image from Gyazo](https://i.gyazo.com/3bcef520129076ae775bc5d2f5f68f40.gif)](https://gyazo.com/3bcef520129076ae775bc5d2f5f68f40)

## コメント機能

### コメント新規投稿
・ワイン記事にコメントを投稿してみましょう！
[![Image from Gyazo](https://i.gyazo.com/e7f108ff998a51e66e93396d07f0f0c5.gif)](https://gyazo.com/e7f108ff998a51e66e93396d07f0f0c5)
・コメントしたい内容を入力してコメントするボタンをクリックします。コメント投稿完了です。UTF8に対応していない絵文字を使うとエラーが出ます。
[![Image from Gyazo](https://i.gyazo.com/c9ec7d9a3427ba3248d8f25a8b3bd945.gif)](https://gyazo.com/c9ec7d9a3427ba3248d8f25a8b3bd945)

### コメント編集
・過去に投稿したコメントを編集してみましょう！
[![Image from Gyazo](https://i.gyazo.com/c5749ab0118faca34a88aac728248506.gif)](https://gyazo.com/c5749ab0118faca34a88aac728248506)
・編集したい内容を入力して、更新するをクリックします。コメントの編集完了です。
[![Image from Gyazo](https://i.gyazo.com/3ba114e7568c9c36017b57384fd9109e.gif)](https://gyazo.com/3ba114e7568c9c36017b57384fd9109e)
・コメントを編集できるのは、そのコメントをした本人のみです
[![Image from Gyazo](https://i.gyazo.com/e8c1c7688510d545199133f3300177ed.gif)](https://gyazo.com/e8c1c7688510d545199133f3300177ed)

### コメント削除
・過去に投稿したコメントを削除してみましょう！コメントが削除されました。
[![Image from Gyazo](https://i.gyazo.com/b7fbae2d78b8118e6f4de28e52907b1e.gif)](https://gyazo.com/b7fbae2d78b8118e6f4de28e52907b1e)
・コメントを削除できるのは、そのコメントをした本人のみです。
[![Image from Gyazo](https://i.gyazo.com/a5a4f6ae3545f6b4c4bc06fd6d6dee9c.gif)](https://gyazo.com/a5a4f6ae3545f6b4c4bc06fd6d6dee9c)

## フォロー・フォロワー機能

### フォローする
・気になるユーザーさんをフォローしてみましょう！
[![Image from Gyazo](https://i.gyazo.com/b366b54db63b2d75b80920c39ce1a8f0.gif)](https://gyazo.com/b366b54db63b2d75b80920c39ce1a8f0)
・私がフォローしている事が反映されました。フォロー完了です。
[![Image from Gyazo](https://i.gyazo.com/e8ae94c69bd5158dfb333cb0e3240465.gif)](https://gyazo.com/e8ae94c69bd5158dfb333cb0e3240465)
・フォローを解除したいときは、フォローをやめるのリンクをクリックしてください。フォローが解除されました。
[![Image from Gyazo](https://i.gyazo.com/e697405c9508b93aecf6d8a9927d07ad.gif)](https://gyazo.com/e697405c9508b93aecf6d8a9927d07ad)

### フォロー・フォロワーの関係
・私のフォロワーを確認してみましょう！一人のユーザーにフォローされています。
[![Image from Gyazo](https://i.gyazo.com/310b3e95d0c82fa6302ae4351706eea5.gif)](https://gyazo.com/310b3e95d0c82fa6302ae4351706eea5)
・今度はその相手ユーザーのフォローについて確認してみましょう！これでフォローとフォロワーの関係性が確認できました。
[![Image from Gyazo](https://i.gyazo.com/5ad3361a38b95822a8d641c6028a20ec.gif)](https://gyazo.com/5ad3361a38b95822a8d641c6028a20ec)
・フォローもしくはフォロワーの関係性がない時は、両者このように表示されます。
[![Image from Gyazo](https://i.gyazo.com/8bab875b5fba1526615d9d58d6ea2efa.gif)](https://gyazo.com/8bab875b5fba1526615d9d58d6ea2efa)

## いいね機能  

### いいねとその解除  
・良いと思った記事があったらいいねをしましょう！  
[![Image from Gyazo](https://i.gyazo.com/8b360574c17dcc0f5177dca8aef538aa.gif)](https://gyazo.com/8b360574c17dcc0f5177dca8aef538aa)
・いいねの解除も可能です  
[![Image from Gyazo](https://i.gyazo.com/1a1ed950ad3b4ade0cbb2deb00455ffb.gif)](https://gyazo.com/1a1ed950ad3b4ade0cbb2deb00455ffb)

### いいね一覧ページ
・自分がいいねをつけた記事は、自身のマイページから確認可能です。  
[![Image from Gyazo](https://i.gyazo.com/81498daf6d0958e2765be499a753f207.gif)](https://gyazo.com/81498daf6d0958e2765be499a753f207)

# 実装予定の機能
現在、ランキング機能を実装中です。
今後は、検索機能、  
S3導入、必要な各機能のテストを実装予定です。

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/61fcbd94cfb1fc876f6cb7a69f065d48.jpg)](https://gyazo.com/61fcbd94cfb1fc876f6cb7a69f065d48)

# テーブル設計

## usersテーブル

| Column             | Type    | Options
|--------------------|---------|---------------------------|
| nickname           | string  | null:false               |
| email              | string  | null:false,  unique:true |
| encrypted_password | string  | null:false               |
| last_name          | string  | null:false               |
| first_name         | string  | null:false               |
| last_name_kana     | string  | null:false               |
| first_name_kana    | string  | null:false               |
| birthday           | date    | null:false               |

## Association
has_many :wine_articles

has_many :comments

has_many :favorites  

has_many:favorite_wine_articles,
through: :favorites,  
source: :wine_article

has_many :relationships,  
class_name: "Relationship",  
foreign_key: :user_follows_id,  
dependent: :destroy  

has_many :followers,  
through:  
:reverse_of_relationships,  
source: :user_follows


has_many :reverse_of_relationships,  
class_name: "Relationship",  
foreign_key: :user_followed_id,  
dependent: :destroy  

has_many :followings,  
through: :relationships,  
source: :user_followed  


## wine_articlesテーブル

| Column             | Type       | Options
|--------------------|------------|--------------------------------|
| wine_name          | string     | null: false                    |
| wine_name_kana     | string     |                                |
| wine_price         | integer    | null: false                    |
| wine_shop          | string     | null: false                    |
| title              | string     | null: false                    |
| comment            | text       | null: false                    |
| wine_type_id       | integer    | null: false                    |
| wine_taste_id      | integer    | null: false                    |
| user_id            | references | null: false,  foreign_key: true |

## Association
belongs_to :user  

has_many :comments
extend  
ActiveHash::Associations:  
:ActiveRecordExtensions  

belongs_to :wine_type
extend  
ActiveHash::Associations:  
:ActiveRecordExtensions  

belongs_to :wine_taste  

has_many :favorites

## Commentsテーブル

| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| text               | text       | null:false                    |
| user_id            | references | null:false, foreign_key: true |
| wine_article_id    | references | null:false, foreign_key: true |

## Association
belongs_to :user  
belongs_to :wine_article

## Favoritesテーブル

| Column             | Type       | Options     |
|--------------------|------------|-------------|
| user_id            | integer    |             |
| wine_article_id    | integer    |             |

## Association
belongs_to :user  
belongs_to :wine_article

## Relationshipsテーブル

| Column                  | Type       | Options |
|-------------------------|------------|---------|
| user_follows_id         | integer    |         |
| user_followed_id        | integer    |         |

## Association
belongs_to :user_follows_id, class_name: "User"  

belongs_to :user_followed_id, class_name: "User"

# 画面遷移図

### 上段：ユーザー管理機能とワイン記事管理機能の遷移図  
### 中段：ワイン記事詳細機能からはじまるコメント機能・フォロー・フォロワー機能の遷移図
### 下段：ワイン記事詳細機能からはじまるいいね機能の遷移図
[![Image from Gyazo](https://i.gyazo.com/860796be1a5e5db26806c395eb859a5d.jpg)](https://gyazo.com/860796be1a5e5db26806c395eb859a5d)

# 開発環境
・フロントエンド  
・バックエンド  
・インフラ  
・テスト  
・テキストエディタ  
・タスク管理

# ローカルでの動作方法
以下のコマンドを順に実行。  

％ git clone  
https://github.com/kzen23  
/wine-park-37082.git  

％ cd wine-park-37082

％ bundle install  

％ yarn install

# 工夫したポイント
## ①タスク管理
Furimaアプリ作成時、タスク管理の重要性・効率性を強く感じたのでチャレンジをしました。
自分が想定している作業時間と、実際の作業時間にはギャップがあることを感じ設計段階の重要性を感じることができました。  

## ②年齢認証
お酒(ワイン)を取り扱うアプリケーションなので、20歳未満のユーザーが万が一に訪れた場合、新規登録できてしまうことは望ましくないと思いました。
新規登録時の生年月日をselect方式にし、20歳から100歳までの年齢層を時間が進んでもカバー出来るようにしました。
日付により漏れてしまう部分は、コントローラーで条件分岐をし、保存できる時とできない時で分けました。  

## ③結合テスト
exampleの洗い出しなど考えて吐き出せるようになりました。
コメント機能の編集の結合テストは、コメントの紐付けの仕方にとても苦労しました。
問題解決のためにとても粘り強く悩み、取り組んだ実装でしたので私にとって感慨深いです。

また<コメント編集・削除機能><フォロー・フォロワー機能>においては初めて取り組む内容でした。
検索をして最後まで実装することができたので、カリキュラムを終えた時より、理解力が増しました。