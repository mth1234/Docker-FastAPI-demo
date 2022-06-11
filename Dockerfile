# python3.9 のイメージをダウンロード
FROM python:3.9-buster
ENV PYTHONUNBUFFERED=1

WORKDIR /src

# pip を使って poetry をインストール
RUN pip install poetry

# poetry の定義ファイルをコピー (存在する場合)
COPY pyproject.toml* poetry.lock* ./

# poetry でライブラリをインストール (pyproject.toml が既にある場合)
RUN poetry config virtualenvs.in-project true
RUN if [ -f pyproject.toml ]; then poetry install; fi

# uvicorn のサーバーを立ち上げる
ENTRYPOINT ["poetry", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--reload"]