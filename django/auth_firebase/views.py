from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import Student
from .serializers import StudentSerializer
import firebase_admin
from firebase_admin import auth




class StudentAPIView(APIView):
    def get(self, request):
        students = Student.objects.all()
        serializer = StudentSerializer(students, many=True)
        return Response(serializer.data)

    def post(self, request):
        try:
            firebase_user = auth.get_user_by_email(request.data.get('email'))

            student, created = Student.objects.get_or_create(
                email=firebase_user.email,
                defaults={'name': firebase_user.display_name or 'Unknown',
                          'firebase_uid': firebase_user.uid}
            )
            if not created:
                student.name = firebase_user.display_name or 'Unknown'
                student.firebase_uid = firebase_user.uid
                student.save()

            return Response({"message": "Student created or updated successfully"}, status=status.HTTP_201_CREATED)
        except auth.FirebaseError:
            return Response({"error": "Firebase user not found"}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
