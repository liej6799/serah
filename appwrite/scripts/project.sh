appwrite teams create --teamId 'serah' --name 'serah'

appwrite projects create --projectId 'serah' --name 'serah' --teamId 'serah'

appwrite storage createBucket --bucketId 'st_maybank' --name 'st_maybank' --permission 'bucket'

appwrite databases create --databaseId 'db_maybank' --name 'db_maybank'
appwrite databases createCollection --databaseId 'db_maybank' --collectionId 'tb_statement' --name 'tb_statement' --permission 'collection' --read 'role:all' --write 'role:all'
appwrite databases createStringAttribute --databaseId 'db_maybank' --collectionId 'tb_statement' --key 'name' --size '512' --required 'true'
appwrite databases createIntegerAttribute --databaseId 'db_maybank' --collectionId 'tb_statement' --key 'date' --required 'true'
appwrite databases createStringAttribute --databaseId 'db_maybank' --collectionId 'tb_statement' --key 'description' --size '512' --required 'false'
appwrite databases createFloatAttribute --databaseId 'db_maybank' --collectionId 'tb_statement' --key 'amount' --required 'true'
appwrite databases createFloatAttribute --databaseId 'db_maybank' --collectionId 'tb_statement' --key 'balance' --required 'false'
