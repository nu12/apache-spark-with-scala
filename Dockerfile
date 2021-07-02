FROM python:3.8

RUN apt-get update && apt-get upgrade -y -qq && apt-get install wget default-jre scala -y -qq \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

RUN pip install numpy pandas nltk matplotlib seaborn sklearn jupyter tensorflow tensorboard py4j spylon-kernel \
 && python -m spylon_kernel install

RUN wget https://archive.apache.org/dist/spark/spark-3.1.1/spark-3.1.1-bin-hadoop2.7.tgz \
 && tar -zxvf spark-3.1.1-bin-hadoop2.7.tgz \
 && rm spark-3.1.1-bin-hadoop2.7.tgz

ENV SPARK_HOME='/spark-3.1.1-bin-hadoop2.7'
ENV PATH=$SPARK_HOME:$PATH
ENV PYTHONPATH=$SPARK_HOME/python:$PYTHONPATH

EXPOSE 8888 6006 4040

WORKDIR /notebooks

CMD ["jupyter", "notebook","--ip","0.0.0.0", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]