from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
import json
from pymongo import MongoClient

# Create your views here.

@csrf_exempt
def insert_restaurant(request):
    if request.method == 'POST':
    	
        try:
            data = json.loads(request.body)
            
            

            print(data)
            
            # client = MongoClient('mongodb://localhost:27017/')
            # db = client['mydatabase']
            
            # # Insert the user data into the 'users' collection
            # users = db['Servicos']
            # users.insert_one(data)
            


                
            return JsonResponse({'status': 'success'})
        except Exception as e:
            return JsonResponse({'status': 'error', 'message': str(e)})
    else:
        return JsonResponse({'status': 'error', 'message': 'Invalid request method'})

