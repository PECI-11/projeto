from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
import json
#from myapp.models import Empresa  # Import the Empresa model from your app models.py file

#@csrf_exempt
def empresa_view(request):
    print("ola")
    print(request)
    if request.method == 'POST':
    	
        try:
            data = json.loads(request.body)
            
            # Save the Empresa data to a JSON file
            # with open('empresa_data.json', 'a') as f:
            #     json.dump(data, f)
            #     f.write('\n')

            print(data)
                
            return JsonResponse({'status': 'success'})
        except Exception as e:
            return JsonResponse({'status': 'error', 'message': str(e)})
    else:
        return JsonResponse({'status': 'error', 'message': 'Invalid request method'})
