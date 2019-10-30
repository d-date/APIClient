rm -rf ./Petstore

openapi-generator generate \
-t swift \
-i https://petstore.swagger.io/v2/swagger.json \
-g swift4 \
-c swift.json \
-o ./Petstore

if type "xcodegen" > /dev/null 2>&1; then
  cd Petstore
  xcodegen generate
  if type "carthage" > /dev/null 2>&1; then
    carthage update --no-use-binaries --platform ios --cache-builds
  fi
fi

if type "swiftlint" > /dev/null 2>&1; then
  cd Petstore
  swiftlint autocorrect
fi
