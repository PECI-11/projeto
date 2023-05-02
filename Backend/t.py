from bson import ObjectId
from pymongo import MongoClient

# connect to MongoDB
client = MongoClient('mongodb://localhost:27017/')

# select the database and collection
db = client['mydatabase']
users = db['users']

# find the document with the given ObjectId
profile = users.find_one({"user_info.email": 'lopes@ua.pt'})

# print the document
#print(profile['services'][-1]['images'])
imagem = profile['services'][-1]['images'][0]
print(imagem)

import base64

# Retrieve the encoded image string from MongoDB

# Decode the base64 string to bytes
image_bytes = base64.b64decode(imagem)

# Write the bytes to a file (in this case, a PNG image)
with open("image.png", "wb") as f:
    f.write(image_bytes)