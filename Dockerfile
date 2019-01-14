FROM ubuntu:16.04
MAINTAINER hugoxia@126.com
WORKDIR /home
RUN mkdir ~/.pip
RUN cd /etc/apt && cp sources.list sources.list.bak
COPY ./sources.list /etc/apt/sources.list
COPY ./pip.conf ~/.pip/pip.conf
COPY ./requirements.txt /home/
RUN apt-get update && apt-get install -y \
vim \
python3 \
python3-dev \
python3-pip
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
RUN jupyter-nbextension install rise --py --sys-prefix
RUN jupyter-nbextension enable rise --py --sys-prefix
RUN jupyter notebook --generate-config
EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0", "--port=8888", "--allow-root"]
