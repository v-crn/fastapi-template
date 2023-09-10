# fastapi-template

## 概要

FastAPI のテンプレートリポジトリです。

## Deploy

### 1. プロジェクトIDの設定

`.env.*` に `PROJECT_ID_*` を設定しておきます。ここで `*` は開発環境であれば `dev`、本番環境であれば `prod` など、環境ごとに環境変数を使い分けるための接尾辞です。
たとえば、`.env.dev.template` を基に `.env.dev` を作成し、`PROJECT_ID_DEV` に利用している GCP プロジェクトのプロジェクトIDを設定します。

### サービスアカウントの作成

1. GCP の「IAM と管理」 > 「サービスアカウント」から任意の名前（例: "my-api"）のサービスアカウントを作成します。
2. 作成したサービスアカウントのメールアドレスを `.env.*` の `SERVICE_ACCOUNT_*` に記述します。サービスアカウント名がサービス名と同じ場合はデフォルトの設定で問題ないのでこの作業をスキップできます。

### gcloud の準備

gcloud の認証を済ませておきます。

```sh
gcloud auth login
```

### 3. Cloud Run へのデプロイ

```sh
make deploy_dev
```

## Tests

### Cloud Run にデプロイしたサービスについてテストを行う準備

1. `pytest.ini.template` を基に `pytest.ini` を作成します。
2. サービスアカウントの鍵ファイルを作成し、本プロジェクト内に保存してください。そのファイルパスを `pytest.ini` 内の `GOOGLE_APPLICATION_CREDENTIALS` に記述します。
3. デプロイ済みのサービスの URL を `pytest.ini` 内の `API_URL_*` に記述します。
4. 完了

### テストコマンド

```sh
# すべてのテストを実行
make test

# テストファイルを指定して実行
make test FILE=tests/api/routes/version/test_api_version_dev.py

# テスト関数を指定して実行
make test FUNC=test_api_version_local__GETリクエストのステータスコードが200であることを確認する
```
