cd `dirname $0`

# api-spec.jsonをダウンロードする。
./gradlew downloadApiSpec

# 自動生成の成果物を削除する。
cd ./src
ls | grep -v -E 'node_modules|package-lock.json$' | xargs rm -f -r
cd ..

# 自動生成する。
./gradlew openApiGenerate

# ビルドの成果物を削除する。
cd ./src
rm -f -r ./dist

# ビルドする。
npm ci
npm run-script build

# ビルドの成果物をパッケージする。
cd ./dist
npm pack
