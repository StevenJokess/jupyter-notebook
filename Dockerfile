FROM ubuntu:16.04
MAINTAINER hugoxia@126.com
WORKDIR /home
RUN apt-get update && apt-get install -y \
vim \
wget \
python \
python-dev
RUN apt-get remove python-pip
RUN wget https://bootstrap.pypa.io/ez_setup.py -O - | python
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install jupyter
RUN pip install RISE
RUN pip install numpy
RUN pip install pandas
RUN pip install pillow
RUN pip install requests
RUN jupyter-nbextension install rise --py --sys-prefix
RUN jupyter-nbextension enable rise --py --sys-prefix
EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0", "--port=8888", "--allow-root"]
