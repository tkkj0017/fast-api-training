FROM python:3.9-alpine
#ENV PYTHONUNBUFFERED=1
#
#WORKDIR /src
#
## poetyをインストール
#RUN pip install poetry
#
## poetryの定義ファイルをコピー
#COPY pyproject.toml* poetry.lock* ./
#
## poetryでライブラリをインストール(pyproject.toml)が既にある場合
#RUN poetry config virtualenvs.in-project true
#RUN if [ -f pyproject.toml ]; then poetry install; fi
#
## unicornのサーバー立ち上げ
#ENTRYPOINT ["poetry", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--reload"]

WORKDIR /app

COPY requirements.txt .
# コンテナ内で必要なパッケージをインストール
RUN apk add --no-cache build-base \
 && pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt \
 && apk del build-base

COPY . /app
EXPOSE 8000
# FastAPIを8000ポートで待機
CMD ["uvicorn", "api.main:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]
