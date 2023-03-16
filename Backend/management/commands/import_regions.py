import pandas as pd
from pymongo import MongoClient
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    help = 'Import regions from Excel file to MongoDB database'

    def handle(self, *args, **options):
        # Connect to MongoDB database
        client = MongoClient('mongodb://localhost:27017/')
        db = client['regions']

        # Read Excel file into a Pandas dataframe
        regions_df = pd.read_excel('freguesias-metadata.xlsx')

        # Convert dataframe to a list of dictionaries
        regions_data = regions_df.to_dict('records')

        # Insert data into MongoDB collection
        db.regions.insert_many(regions_data)

        self.stdout.write(self.style.SUCCESS('Regions imported successfully'))