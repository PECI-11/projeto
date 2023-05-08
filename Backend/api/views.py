from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
import json
import requests
from pymongo import MongoClient


# Create your views here.

@csrf_exempt
def services_by_distrito_tipo(request, distrito, tipo=None):
    if request.method == 'GET':
        # distrito = request.GET.get('distrito')
        # tipo = request.GET.get('tipo')
        client = MongoClient('mongodb://localhost:27017/')
        db = client['mydatabase']
        services = db['Servicos']
        services_to_return = []
        
        query = {'distrito': distrito}
        if tipo:
            query['tipo_servico'] = tipo

        result = services.find(query)
        result_list = list(result)
        for x in result_list:
            x['_id'] = str(x['_id'])
            services_to_return.append(x)
        
        print(len(services_to_return))
        if len(services_to_return) == 0:
            response_data = {
                'Error': 'No services found'
            }
        else:
            response_data = {
                'district_services': services_to_return
            }

        return JsonResponse(response_data)
    return JsonResponse({'error': 'Method Not Allowed'}, status=405)

@csrf_exempt
def services_by_distrito(request, distrito):
    if request.method == 'GET':
        # distrito = request.GET.get('distrito')
        # tipo = request.GET.get('tipo')
        client = MongoClient('mongodb://localhost:27017/')
        db = client['mydatabase']
        services = db['Servicos']
        services_to_return = []
        
        query = {'distrito': distrito}
        

        result = services.find(query)
        result_list = list(result)
        for x in result_list:
            x['_id'] = str(x['_id'])
            services_to_return.append(x)
        
        print(len(services_to_return))
        if len(services_to_return) == 0:
            response_data = {
                'Error': 'No services found'
            }
        else:
            response_data = {
                'district_services': services_to_return
            }

        return JsonResponse(response_data)
    return JsonResponse({'error': 'Method Not Allowed'}, status=405)

@csrf_exempt
def services_by_concelho(request):
    if request.method == 'GET':
        concelho = request.GET.get('concelho')
        client = MongoClient('mongodb://localhost:27017/')
        db = client['mydatabase']
        services = db['Servicos']
        services_to_return = []

        #anuncio = services.find_one

        # for x in services.find():
        #     print(x)
        result = services.find({'concelho': concelho})
        result_list = list(result)
        for x in result_list:
            x['_id'] = str(x['_id'])
            services_to_return.append(x)
            
        
        # for x in services_to_return:
        #     print(x)

        # for services_to_return in services_to_return:
        #         services_to_return['_id'] = str(services_to_return['_id'])

        if len(services_to_return) == 0:
            response_data = {
                'Error': 'No services found'
            }
        else:
            response_data = {
                    'concelho_services': services_to_return
                            }
            



        return JsonResponse(response_data)
    return JsonResponse({'error': 'Method Not Allowed'}, status=405)


@csrf_exempt
def services_by_freguesia(request):
    if request.method == 'GET':
        freguesia = request.GET.get('freguesia')
        client = MongoClient('mongodb://localhost:27017/')
        db = client['mydatabase']
        services = db['Servicos']
        services_to_return = []

        #anuncio = services.find_one

        # for x in services.find():
        #     print(x)
        result = services.find({'freguesia': freguesia})
        result_list = list(result)
        for x in result_list:
            x['_id'] = str(x['_id'])
            services_to_return.append(x)
            
        
        # for x in services_to_return:
        #     print(x)

        # for services_to_return in services_to_return:
        #         services_to_return['_id'] = str(services_to_return['_id'])

        if len(services_to_return) == 0:
            response_data = {
                'Error': 'No services found'
            }
        else:
            response_data = {
                    'freguesia_services': services_to_return
                }
            

        return JsonResponse(response_data)
    return JsonResponse({'error': 'Method Not Allowed'}, status=405)
    