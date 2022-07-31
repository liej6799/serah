var index = require('./index.js')
const req = {}
req.env = {}
const res = {}
res.json = {}

req.env["APPWRITE_FUNCTION_ENDPOINT"] = 'https://192.168.43.56/v1'
req.env["APPWRITE_FUNCTION_API_KEY"] = 'f2d966e50bedbe1141ac68ac2043e8fe84568dbcb0f30315fac932a1b99baedf0f57c4c46aead64c00d1f1534f48f39c61a3220a65ad0812a0baafc73c34622c5e9e1d8cc366c939940f518d7bba6bb8bafc2857d13b42a90caf807f5df469a35369d4835f177fc304e5df16e643cfb123ac30976bd8ddf00541592e9ada9b1a'
req.env["APPWRITE_FUNCTION_PROJECT_ID"] = '62e14fff092f74e54e15'

index(req, res)
console.log(res)