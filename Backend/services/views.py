from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
import json
import requests
from pymongo import MongoClient
from bson.objectid import ObjectId  # Import ObjectId from bson

# Create your views here.

@csrf_exempt
def insert_restaurant(request):
    if request.method == 'POST':
        #print((request.body))
        data = json.loads(request.body)

        try:
            data = json.loads(request.body)
            # print(data)
            data['tipo_servico'] = 'Restauracao'
            

            
            latitude = float(data['latitude'])
            longitude = float(data['longitude'])
            #print('https://json.geoapi.pt/gps/'+str(latitude)+', '+str(longitude)+'/base')
            response = requests.get('https://json.geoapi.pt/gps/'+str(latitude)+', '+str(longitude))
            
            resposta = json.loads(response.text)
            print(resposta)
            
            data['distrito'] = resposta['distrito']
            data['concelho'] = resposta['concelho']
            data['freguesia'] = resposta['freguesia']
            data['rua'] = 'nao_existente'
            #resposta['rua'] # sometimes this doesn't exist so i have to handle that

            if ('rua' in resposta):
                data['rua'] = resposta['rua'] # sometimes this doesn't exist so i have to handle that
            

            

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
            data['tipo_servico'] = 'Alojamento'
            

            print(data)
            latitude = float(data['latitude'])
            longitude = float(data['longitude'])
            #print('https://json.geoapi.pt/gps/'+str(latitude)+', '+str(longitude)+'/base')
            response = requests.get('https://json.geoapi.pt/gps/'+str(latitude)+', '+str(longitude))
            
            resposta = json.loads(response.text)
            print(resposta)
            
            data['distrito'] = resposta['distrito']
            data['concelho'] = resposta['concelho']
            data['freguesia'] = resposta['freguesia']
            data['rua'] = 'nao_existente'
            #resposta['rua'] # sometimes this doesn't exist so i have to handle that

            if ('rua' in resposta):
                data['rua'] = resposta['rua'] # sometimes this doesn't exist so i have to handle that
            

            user_email = data['user_email'] # user's email, this way I know which user to


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
def insert_monumentos(request):
    if request.method == 'POST':
    	
        try:
            data = json.loads(request.body)
            data['tipo_servico'] = 'Monumento'
            

            print(data)
            latitude = float(data['latitude'])
            longitude = float(data['longitude'])
            #print('https://json.geoapi.pt/gps/'+str(latitude)+', '+str(longitude)+'/base')
            response = requests.get('https://json.geoapi.pt/gps/'+str(latitude)+', '+str(longitude))
            
            resposta = json.loads(response.text)
            
            data['distrito'] = resposta['distrito']
            data['concelho'] = resposta['concelho']
            data['freguesia'] = resposta['freguesia']
            data['rua'] = 'nao_existente'
            #resposta['rua'] # sometimes this doesn't exist so i have to handle that

            if ('rua' in resposta):
                data['rua'] = resposta['rua'] # sometimes this doesn't exist so i have to handle that
            
            #print(data)

            user_email = data['user_email'] # user's email, this way I know which user to


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


#function to retrieve services of a given user
@csrf_exempt
def request_user_services(request):
    if request.method == 'GET':
        email = request.GET.get('email')

        #db query
        client = MongoClient('mongodb://localhost:27017/')
        db = client['mydatabase']
        users = db['users']
        profile = users.find_one({"user_info.email": email})

        services = profile.get('services', []) # Get the services list from the profile, or an empty list if it's not present

        # Convert each service's ObjectId to a string for serialization
        for service in services:
            service['_id'] = str(service['_id'])
        
        response_data = {
            'user_services': services
        }

        return JsonResponse(response_data)

    return JsonResponse({'error': 'Method Not Allowed'}, status=405)


#function to to update the user's restaurant (crud)
@csrf_exempt
def update_restaurant(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        service_id = data['id']
        print(data.keys())

        client = MongoClient('mongodb://localhost:27017/')
        db = client['mydatabase']
        users = db['users']

        # Find the user with the matching service ID
        user = users.find_one({'services._id': ObjectId(service_id)})

        #print(user['services'])

        if user is not None:
            # Find the index of the service within the user's services list
            service_index = next((index for index, s in enumerate(user['services']) if str(s['_id']) == service_id), None)
            print(service_index)
            print(user['services'][0].keys())

            nData = {}
            nData['name'] = data['name']
            nData['latitude'] = data['latitude']
            nData['longitude'] = data['longitude']
            nData['tipoEstabelecimento'] = data['establishmentTypes']
            nData['imageDescriptions'] = data['imageDescriptions']
            nData['ementa'] = data['menu']
            nData['images'] = data['images']
            nData['hours'] = data['hours']
            nData['description'] = data['description']
            nData['promo'] = data['promo']
            nData['email'] = data['user_email']

            print(nData.keys())
            

            if service_index is not None:
                # Delete the service from the user's services list
                del user['services'][service_index]
                users.save(user)
                insert_restaurant_manualy(nData)
                
                return JsonResponse({'delete': 'deleted'})
            else:
                return JsonResponse({'error': 'Service not found'}, status=404)
        else:
            return JsonResponse({'error': 'User not found'}, status=404)

    return JsonResponse({'error': 'Method Not Allowed'}, status=405)



def insert_restaurant_manualy(dados):
        # print((request.body))
        data = dados

       
        data['tipo_servico'] = 'Restauracao'

        latitude = float(data['latitude'])
        longitude = float(data['longitude'])
        #print('https://json.geoapi.pt/gps/'+str(latitude)+', '+str(longitude)+'/base')
        response = requests.get('https://json.geoapi.pt/gps/'+str(latitude)+', '+str(longitude))
        print(response)
        resposta = json.loads(response.text)
        
        data['distrito'] = resposta['distrito']
        data['concelho'] = resposta['concelho']
        data['freguesia'] = resposta['freguesia']
        data['rua'] = 'nao_existente'
            #resposta['rua'] # sometimes this doesn't exist so i have to handle that

        if ('rua' in resposta):
            data['rua'] = resposta['rua'] # sometimes this doesn't exist so i have to handle that
        delete_existing_services(latitude, longitude)

        user_email = data['email'] # user's email, this way I know which user to


        client = MongoClient('mongodb://localhost:27017/')
        db = client['mydatabase']

        
        # Insert the user data into the 'users' collection
        services = db['Servicos']
        users = db['users']
        services.insert_one(data)
        users.update_one({'user_info.email': user_email}, {'$push': {'services': {'$each': [data]}}})
            

def delete_existing_services(latitude, longitude):
    client = MongoClient('mongodb://localhost:27017/')
    db = client['mydatabase']
    services = db['Servicos']
    
    matching_services = []
    
    for service in services.find({'latitude': str(latitude)}):
        if service['longitude'].strip() == str(longitude):
            matching_services.append(service)
    
    print("Matching services:")
    for service in matching_services:
        print(service)
    print(len(matching_services))
    
    try:
        if matching_services:
            for service in matching_services:
                result = services.delete_one({'_id': service['_id']})
            print(f"{len(matching_services)} service(s) deleted")
        else:
            print("No matching services found for deletion.")
    except Exception as e:
        print(f"An error occurred during deletion: {str(e)}")


#function to to update the user's accomodation (crud)
@csrf_exempt
def update_accomodation(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        service_id = data['id']
        print(data.keys())

        client = MongoClient('mongodb://localhost:27017/')
        db = client['mydatabase']
        users = db['users']

        # Find the user with the matching service ID
        user = users.find_one({'services._id': ObjectId(service_id)})

        #print(user['services'])

        if user is not None:
            # Find the index of the service within the user's services list
            service_index = next((index for index, s in enumerate(user['services']) if str(s['_id']) == service_id), None)
            print(service_index)
            print(user['services'][0].keys())

            nData = {}
            nData['name'] = data['name']
            nData['latitude'] = data['latitude']
            nData['longitude'] = data['longitude']
            nData['bedroom_prices'] = data['bedroomPrices']
            nData['bedroom_type'] = data['bedroomType']
            nData['services'] = data['services']
            nData['image_descriptions'] = data['imageDescriptions']
            nData['images'] = data['images']
            nData['description'] = data['description']
            nData['user_email'] = data['user_email']

            print(nData.keys())
            

            if service_index is not None:
                # Delete the service from the user's services list
                del user['services'][service_index]
                users.save(user)
                insert_alojamento_manualy(nData)
                
                return JsonResponse({'delete': 'deleted'})
            else:
                return JsonResponse({'error': 'Service not found'}, status=404)
        else:
            return JsonResponse({'error': 'User not found'}, status=404)

    return JsonResponse({'error': 'Method Not Allowed'}, status=405)


def insert_alojamento_manualy(dados):
        # print((request.body))
        data = dados

       
        data['tipo_servico'] = 'Alojamento'

        latitude = float(data['latitude'])
        longitude = float(data['longitude'])
        #print('https://json.geoapi.pt/gps/'+str(latitude)+', '+str(longitude)+'/base')
        response = requests.get('https://json.geoapi.pt/gps/'+str(latitude)+', '+str(longitude))
        print(response)
        resposta = json.loads(response.text)
        
        data['distrito'] = resposta['distrito']
        data['concelho'] = resposta['concelho']
        data['freguesia'] = resposta['freguesia']
        data['rua'] = 'nao_existente'
            #resposta['rua'] # sometimes this doesn't exist so i have to handle that

        if ('rua' in resposta):
            data['rua'] = resposta['rua'] # sometimes this doesn't exist so i have to handle that
        delete_existing_services_acc(latitude, longitude)

        user_email = data['user_email'] # user's email, this way I know which user to


        client = MongoClient('mongodb://localhost:27017/')
        db = client['mydatabase']

        
        # Insert the user data into the 'users' collection
        services = db['Servicos']
        users = db['users']
        services.insert_one(data)
        users.update_one({'user_info.email': user_email}, {'$push': {'services': {'$each': [data]}}})
            

def delete_existing_services_acc(latitude, longitude):
    client = MongoClient('mongodb://localhost:27017/')
    db = client['mydatabase']
    services = db['Servicos']
    
    matching_services = []
    
    for service in services.find({'latitude': str(latitude)}):
        if service['longitude'].strip() == str(longitude):
            matching_services.append(service)
    
    print("Matching services:")
    for service in matching_services:
        print(service)
    print(len(matching_services))
    
    try:
        if matching_services:
            for service in matching_services:
                result = services.delete_one({'_id': service['_id']})
            print(f"{len(matching_services)} service(s) deleted")
        else:
            print("No matching services found for deletion.")
    except Exception as e:
        print(f"An error occurred during deletion: {str(e)}")


        #function to to update the user's accomodation (crud)
@csrf_exempt
def update_monument(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        service_id = data['id']
        print(data.keys())

        client = MongoClient('mongodb://localhost:27017/')
        db = client['mydatabase']
        users = db['users']

        # Find the user with the matching service ID
        user = users.find_one({'services._id': ObjectId(service_id)})

        #print(user['services'])

        if user is not None:
            # Find the index of the service within the user's services list
            service_index = next((index for index, s in enumerate(user['services']) if str(s['_id']) == service_id), None)
            print(service_index)
            print(user['services'][0].keys())

            nData = {}
            nData['name'] = data['name']
            nData['latitude'] = data['latitude']
            nData['longitude'] = data['longitude']
            nData['story'] = data['story']
            nData['style'] = data['style']
            nData['accessability'] = data['accessibility']
            nData['imageDescriptions'] = data['imageDescriptions']
            nData['images'] = data['images']
            nData['price'] = data['price']
            nData['schedule'] = data['schedule']
            nData['activity'] = data['activity']
            nData['guide_visit'] = data['guideVisit']
            nData['user_email'] = data['user_email']

            print(nData.keys())
            

            if service_index is not None:
                # Delete the service from the user's services list
                del user['services'][service_index]
                users.save(user)
                insert_monument_manualy(nData)
                
                return JsonResponse({'delete': 'deleted'})
            else:
                return JsonResponse({'error': 'Service not found'}, status=404)
        else:
            return JsonResponse({'error': 'User not found'}, status=404)

    return JsonResponse({'error': 'Method Not Allowed'}, status=405)


def insert_monument_manualy(dados):
        # print((request.body))
        data = dados

       
        data['tipo_servico'] = 'Monumento'

        latitude = float(data['latitude'])
        longitude = float(data['longitude'])
        #print('https://json.geoapi.pt/gps/'+str(latitude)+', '+str(longitude)+'/base')
        response = requests.get('https://json.geoapi.pt/gps/'+str(latitude)+', '+str(longitude))
        print(response)
        resposta = json.loads(response.text)
        
        data['distrito'] = resposta['distrito']
        data['concelho'] = resposta['concelho']
        data['freguesia'] = resposta['freguesia']
        data['rua'] = 'nao_existente'
        #resposta['rua'] # sometimes this doesn't exist so i have to handle that

        if ('rua' in resposta):
            data['rua'] = resposta['rua'] # sometimes this doesn't exist so i have to handle that
        delete_existing_services_mon(latitude, longitude)

        user_email = data['user_email'] # user's email, this way I know which user to


        client = MongoClient('mongodb://localhost:27017/')
        db = client['mydatabase']

        
        # Insert the user data into the 'users' collection
        services = db['Servicos']
        users = db['users']
        services.insert_one(data)
        users.update_one({'user_info.email': user_email}, {'$push': {'services': {'$each': [data]}}})
            

def delete_existing_services_mon(latitude, longitude):
    client = MongoClient('mongodb://localhost:27017/')
    db = client['mydatabase']
    services = db['Servicos']
    
    matching_services = []
    
    for service in services.find({'latitude': str(latitude)}):
        if service['longitude'].strip() == str(longitude):
            matching_services.append(service)
    
    print("Matching services:")
    for service in matching_services:
        print(service)
    print(len(matching_services))
    
    try:
        if matching_services:
            for service in matching_services:
                result = services.delete_one({'_id': service['_id']})
            print(f"{len(matching_services)} service(s) deleted")
        else:
            print("No matching services found for deletion.")
    except Exception as e:
        print(f"An error occurred during deletion: {str(e)}")