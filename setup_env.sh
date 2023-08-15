#!/usr/bin/bash

# Function to install packages using apt-get
install_packages() {
    local packages=("$@")
    for package in "${packages[@]}"; do
        sudo apt-get install -y "$package"
    done
}

# List of packages to install
declare -a apt_packages=(
    "python3.7"
    "python3-pip"
    "mysql-server"
    "git"
    "libmysqlclient-dev"
    "vim"
	"virtualenv"
)

# 1. Install python-3.7.2 and python-pip
python3 --version
sudo apt-get update
install_packages "${apt_packages[@]:0:2}"

# 2. Install mysql-8.0.15
install_packages "${apt_packages[2]}"

# 3. Setup virtual environment
# Make a directory
mkdir envs

# Create virtual environment
virtualenv -p /usr/bin/python3 ./envs/

# Activate virtual environment
source envs/bin/activate

# Output success message
echo "Setup complete. Virtual environment activated."

# 4. Clone git repository
install_packages "${apt_packages[3]}"
git clone "https://github.com/Manisha-Bayya/simple-django-project.git"

# 5. Install requirements
cd simple-django-project/
install_packages "${apt_packages[@]:4:2}"
pip install -r req.txt

# 6. Load sample data into MySQL
# Open MySQL shell
# mysql -u <mysql-user> -p

# Inside MySQL shell, load the sample data
# Replace <absolute-path-to-file> with the actual path to the 'world.sql' file
# mysql> source <absolute-path-to-file>/world.sql
# mysql> exit;

# 7. Edit project settings
# Open settings file in your preferred text editor, e.g., vim
# apt install vim

#uncomment it if it needs
#vim panorbit/settings.py

# ... Edit the settings file as instructed ...

# Save and exit the text editor

# 8. Run the server
# Make migrations
python3 manage.py makemigrations
python3 manage.py migrate

# Rebuild the index for the search feature
python3 manage.py rebuild_index

# Run the server
python3 manage.py runserver 0:8001

echo "Server is up and running. Access it at http://localhost:8001"
