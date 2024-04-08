
from django.core.management.base import BaseCommand
import firebase_admin
from firebase_admin import auth
from auth_firebase.models import Student

class Command(BaseCommand):
    help = 'Sync Firebase users with the local database'

    def handle(self, *args, **kwargs):
        # Firebase 사용자 정보 가져오기
        for user in auth.list_users().iterate_all():
            # Django 데이터베이스에 사용자 정보 저장
            student, created = Student.objects.get_or_create(email=user.email)
            student.name = user.display_name or 'Unknown'
            student.save()
            if created:
                self.stdout.write(self.style.SUCCESS(f'Successfully created student: {user.email}'))
            else:
                self.stdout.write(self.style.SUCCESS(f'Updated existing student: {user.email}'))
