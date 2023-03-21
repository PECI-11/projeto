from django.http import JsonResponse
from django.views.decorators.http import require_GET
from pymongo import MongoClient

@require_GET
def get_concelhos_by_district(request, district_id):
    client = MongoClient('<mongodb_uri>')
    db = client['<mongodb_database_name>']
    concelhos = list(db.regions.find({'nivel': 3, 'distrito': district_id}, {'concelho': 1, '_id': 0}))
    print(concelhos)
    client.close()
    return JsonResponse(concelhos, safe=False)



@require_GET
def get_freguesias_by_concelho(request, concelho_id):
    client = MongoClient('<mongodb_uri>')
    db = client['<mongodb_database_name>']
    freguesias = list(db.regions.find({'nivel': 3, 'concelho': concelho_id}, {'freguesia': 1, '_id': 0}))
    print(freguesias)
    client.close()
    return JsonResponse(freguesias, safe=False)