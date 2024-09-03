# ベースイメージを指定（Python 3.11を使用）
FROM python:3.11-slim AS builder

# 必要なパッケージのインストール（git含む）
RUN apt-get update && apt-get install -y \
    texlive-full \
    make \
    git \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /app

# Poetryのインストール
RUN pip install poetry

# Poetryの設定（仮想環境を作成しない）
RUN poetry config virtualenvs.create false

# 既存の仮想環境ディレクトリを削除（存在する場合）
RUN rm -rf /app/.venv

# 依存関係ファイルのコピー
COPY pyproject.toml poetry.lock ./

# 依存関係のインストール
RUN poetry install --only main

# プロジェクトのソースコードをコンテナにコピー
COPY . .

# 環境変数の設定
ENV GIT_PYTHON_GIT_EXECUTABLE=/usr/bin/git

# 最終イメージ
FROM builder AS final

# 必要に応じてここで追加の設定やクリーンアップを行う

CMD ["bash"]