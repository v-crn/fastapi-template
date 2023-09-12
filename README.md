# fastapi-template

## 概要

FastAPI のテンプレートリポジトリです。

## Launch on local

以下、環境グループの .env 系ファイルを代表して `.env.dev` を使うこととします。本番環境であれば `.env.prod` などに読み替えてください。

### 準備1: サービスアカウントの作成

GCP の「IAM と管理」 > 「サービスアカウント」から任意の名前（例: "my-api"）のサービスアカウントを作成します。ただし、名前は `${SERVICE_NAME}` と同じであれば都合が良いです。

### 準備2: 環境変数の設定

- `.env.*.template` をコピーして各種の .env ファイルを作成してください。
- 本リポジトリで扱う想定の .env 系ファイルは大別して2つのグループに分けられます。
  - 共通: `.env`
    - 環境に依存しない環境変数を定義する
    - デフォルトのままでも問題ない
  - 環境: `.env.dev`, `.env.stg`, `.env.prod`, etc.
    - 環境ごとに切り分けるべき環境変数を定義する
- `.env` 以外の .env 系ファイルを用意する場合、それらは `dotenvs/` の下に保存してください。
- `dotenvs/.env.dev` の設定項目
  - `PROJECT_ID_DEV`: プロジェクトIDを指定する
  - `SERVICE_ACCOUNT_DEV`: IAM からサービスアカウントのメールアドレスをコピーして `dotenvs/.env.dev` の `SERVICE_ACCOUNT_DEV` に記述します。サービスアカウント名がサービス名と同じ場合はデフォルトの設定で問題ないのでこの作業をスキップできます。

## Deploy to Cloud Run

### 準備1: gcloud 認証

gcloud コマンドによるユーザー認証を済ませておきます。

```sh
gcloud auth login
```

### 準備2: gcloud config configurations

次の手順で GCP のプロジェクト設定を作成します。
各種変数の値は必要に応じて変更してください。

```sh
USER_ACCOUNT_EMAIL=user@example.com
PROJECT_NAME=my-project
PROJECT_ID=my-project-12345
REGION=asia-northeast1
ZONE=asia-northeast1-a

gcloud config configurations create ${PROJECT_NAME}
gcloud config set account ${USER_ACCOUNT_EMAIL}
gcloud config set project ${PROJECT_ID}
gcloud config set compute/region ${REGION}
gcloud config set compute/zone ${ZONE}
gcloud config configurations activate ${PROJECT_NAME}
```

### デプロイ用コマンド

```sh
make deploy_dev
```

## Tests

### Cloud Run にデプロイしたサービスについてテストを行う準備

1. `pytest.ini.template` を基に `pytest.ini` を作成します。
2. サービスアカウントの鍵ファイルを作成し、本プロジェクト内に保存してください。そのファイルパスを `pytest.ini` 内の `GOOGLE_APPLICATION_CREDENTIALS` に記述します。
3. デプロイ済みのサービスの URL を `pytest.ini` 内の `API_URL_*` に記述します。

### テスト用コマンド

```sh
# すべてのテストを実行
make test

# テストファイルを指定して実行
make test FILE=tests/api/routes/version/test_api_version_local.py

# テスト関数を指定して実行
make test FUNC=test_api_version_dev__GETリクエストのステータスコードが200であることを確認する
```
