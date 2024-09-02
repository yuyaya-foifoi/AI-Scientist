# ベースイメージを指定（Python 3.11を使用）
FROM python:3.11-slim

RUN apt update && apt install -y \
    texlive-full \
    make

# 作業ディレクトリを設定
WORKDIR /app

# 依存関係ファイルのコピー
COPY pyproject.toml poetry.lock ./

# Poetryのインストール
RUN pip install poetry

# Poetryの設定（仮想環境を作成しない）
RUN poetry config virtualenvs.create false

# 既存の仮想環境ディレクトリを削除（存在する場合）
RUN rm -rf /app/.venv

# 依存関係のインストール
RUN poetry install --only main

# プロジェクトのソースコードをコンテナにコピー
COPY . .

CMD ["bash"]