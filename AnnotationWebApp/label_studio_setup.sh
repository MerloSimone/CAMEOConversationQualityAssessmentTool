#!/bin/bash

echo "Starting setup..."


python step1_create_user.py

python step2_get_authtoken.py

python step3_create_project.py

python step4_load_data.py

#FOR CONVERSATION COMPARISON
#python step5_create_second_project.py

#python step6_load_second_data.py


echo "Setup FINISHED"