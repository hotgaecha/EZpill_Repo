from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from .models import Surveyresponses
import json
from datetime import datetime

@csrf_exempt  # CSRF 검증을 건너뜁니다. (보안상 추천되지 않는 방법)
def survey_response(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)

            survey_response = Surveyresponses(
                firebase_uid=data['firebase_uid'],
                name=data['name'],
                birth_date=data['birth_date'],
                height=data['height'],
                weight=data['weight'],
                pregnancy_week=data['pregnancy_week'],
                supplements=data['supplements'],
                medications=data['medications'],
                allergies=data['allergies'],
                chronic_diseases=data['chronic_diseases'],
                health_concerns=data['health_concerns'],
                investment=data['investment'],
                created_at=datetime.now(),  # 현재 시간을 생성 시간으로 설정
                result=''  # 결과 필드를 비워둡니다.
            )
            survey_response.save()

            return JsonResponse({"status": "success"}, status=200)
        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)}, status=400)

    return JsonResponse({"status": "invalid request"}, status=400)
