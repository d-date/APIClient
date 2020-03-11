rm -rf ./PetStore

openapi-generator generate \
-t swift \
-i https://petstore.swagger.io/v2/swagger.json \
-g swift4 \
-c swift.json \
-o ./PetStore

mkdir ./PetStore/Sources
mkdir ./PetStore/Sources/PetStore
mv ./Petstore/PetStore/Classes/OpenAPIs/APIs ./PetStore/Sources/PetStore/APIs
mv ./Petstore/PetStore/Classes/OpenAPIs/Models ./PetStore/Sources/PetStore/Models
mv ./Petstore/PetStore/Classes/OpenAPIs/APIs.swift ./PetStore/Sources/PetStore/APIs.swift
rm -rf ./Petstore/PetStore

swift package generate-xcodeproj

if type "swiftlint" > /dev/null 2>&1; then
  cd Petstore
  swiftlint autocorrect
fi
