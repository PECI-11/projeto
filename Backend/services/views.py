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
            

            user_email = data['email'] # user's email, this way I know which user to


            client = MongoClient('mongodb://localhost:27017/')
            db = client['mydatabase']


            
            # Insert the user data into the 'users' collection
            services = db['Servicos']
            users = db['users']
            services.insert_one(data)
            users.update_one({'user_info.email': user_email}, {'$push': {'services': {'$each': [data]}}})
            


                
            return JsonResponse({'status': 'success'})
        except Exception as e:
            return JsonResponse({'status': 'error', 'message': str(e)})
    else:
        return JsonResponse({'status': 'error', 'message': 'Invalid request method'})
    
@csrf_exempt
def insert_alojamento(request):
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
    

@csrf_exempt
def insert_monumentos(request):
    if request.method == 'POST':
    	
        try:
            data = json.loads(request.body)
            
            

            print(data)
            
            # client = MongoClient('mongodb://localhost:27017/')
            # db = client['mydatabase']
            
            # # Insert the user data into the 'users' collection
            # users = db['Servicos'] #tenho que organizar esta base de dados, assim que tiver dados posso tratar disso
            # users.insert_one(data)
            


                
            return JsonResponse({'status': 'success'})
        except Exception as e:
            return JsonResponse({'status': 'error', 'message': str(e)})
    else:
        return JsonResponse({'status': 'error', 'message': 'Invalid request method'})

