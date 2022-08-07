var index = require('./index.js')
const req = {}
req.env = {}
const res = {}
res.json = ({

});

req.env["APPWRITE_FUNCTION_ENDPOINT"] = 'https://192.168.100.33/v1'
req.env["APPWRITE_FUNCTION_API_KEY"] = '7eb690394113ae8df1938a6aba840b2d36da9e5655e0fcb4023843af2232281ae83e708c1e54068461ffef4ec7d6bbd502c91391741803e322ae51b6f9e0221794557eb8102b91858c831599034f3cc62738b80bbdf27ef9fe66112de8de7293c96ebaa1fa857ccd04d5d643a7e7885c4f941ee61a81b3469af0a859eedc166c'
req.env["APPWRITE_FUNCTION_PROJECT_ID"] = '62ef2658c28be8ff5d4b'
req.payload = '62ef378186d8b379d82f'
index(req, res)
console.log('res')
req.payload = '62ef2deb527d21b28d5d'
index(req, res)
console.log('res')