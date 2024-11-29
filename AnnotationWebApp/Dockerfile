FROM python:3.9-bookworm
ENV PYTHONUNBUFFERED=1
WORKDIR /code
COPY requirements.txt /code/
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 8080
COPY . /code/
COPY configure_label_studio.sh  configure_label_studio.sh
COPY label_studio_start.sh  label_studio_start.sh
COPY label_studio_setup.sh  label_studio_setup.sh
RUN chmod +x /code/configure_label_studio.sh
RUN chmod +x /code/label_studio_start.sh 
RUN chmod +x /code/label_studio_setup.sh
RUN /code/configure_label_studio.sh
CMD ["label-studio", "start", "--debug"]