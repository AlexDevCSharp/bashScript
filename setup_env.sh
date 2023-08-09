#!/bin/bash

# 1. Install python-3.7.2 and python-pip
sudo apt-get update
sudo apt-get install -y python3.7 python3-pip

# 2. Install mysql-8.0.15
sudo apt-get install -y mysql-server

# 3. Setup virtual environment
# Install virtual environment
sudo pip3 install virtualenv

# Make a directory
mkdir envs

# Create virtual environment
virtualenv -p /usr/bin/python3 ./envs/

# Activate virtual environment
source envs/bin/activate

# Output success message
echo "Setup complete. Virtual environment activated."

# 4. Clone git repository
git clone "https://github.com/Manisha-Bayya/simple-django-project.git"

# 5. Install requirements
cd simple-django-project/
pip install -r requirements.txt

# 6. Load sample data into MySQL
# Open MySQL shell
mysql -u <mysql-user> -p

# Inside MySQL shell, load the sample data
# Replace <absolute-path-to-file> with the actual path to the 'world.sql' file
mysql> source <absolute-path-to-file>/world.sql
mysql> exit;

# 7. Edit project settings
# Open settings file in your preferred text editor, e.g., vim
vim panorbit/settings.py

# ... Edit the settings file as instructed ...

# Save and exit the text editor

# 8. Run the server
# Make migrations
python manage.py makemigrations
python manage.py migrate

# Rebuild the index for the search feature
python manage.py rebuild_index

# Run the server
python manage.py runserver 0:8001

echo "Server is up and running. Access it at http://localhost:8001"


#Remember to replace placeholders like <mysql-user>, <mysql-password>, <mysql-host>, <mysql-port>, <your-email>, <your-email-password>, and <absolute-path-to-file> with actual values as needed.

#After saving this script to a file, make it executable as before and run it to complete the remaining steps of your project setup.
