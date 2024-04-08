from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ezpill', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='basket2',
            fields=[
                ('firebase_uid', models.CharField(max_length=255)),
                ('product_id', models.CharField(max_length=255)),
                ('product_title', models.CharField(db_column='Product_Title', max_length=1024)),
                ('product_per_price', models.CharField(db_column='Product_Per_Price', max_length=255)),
                ('created_at', models.DateTimeField(blank=True, null=True)),
            ],
            options={
                'db_table': 'basket2',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Surveyresponses',
            fields=[
                ('firebase_uid', models.CharField(primary_key=True, max_length=255)),
                ('name', models.CharField(max_length=255, blank=True, null=True)),
                ('birth_date', models.DateField(blank=True, null=True)),
                ('height', models.IntegerField(blank=True, null=True)),
                ('weight', models.IntegerField(blank=True, null=True)),
                ('pregnancy_week', models.IntegerField(blank=True, null=True)),
                ('supplements', models.TextField(blank=True, null=True)),
                ('medications', models.TextField(blank=True, null=True)),
                ('allergies', models.TextField(blank=True, null=True)),
                ('chronic_diseases', models.TextField(blank=True, null=True)),
                ('health_concerns', models.TextField(blank=True, null=True)),
                ('investment', models.CharField(max_length=255, blank=True, null=True)),
                ('created_at', models.DateTimeField(blank=True, null=True)),
                ('result', models.TextField(blank=True, null=True)),
            ],
            options={
                'db_table': 'Surveyresponses',
                'managed': False,
            },
        ),
    ]