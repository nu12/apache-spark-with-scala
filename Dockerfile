FROM python:3.8

RUN apt-get update && apt-get upgrade -y -qq && apt-get install wget default-jre scala -y -qq \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

RUN pip install numpy pandas nltk matplotlib seaborn sklearn jupyter tensorflow tensorboard py4j spylon-kernel \
 && python -m spylon_kernel install

RUN wget https://archive.apache.org/dist/spark/spark-3.1.1/spark-3.1.1-bin-hadoop2.7.tgz \
 && tar -zxvf spark-3.1.1-bin-hadoop2.7.tgz \
 && rm spark-3.1.1-bin-hadoop2.7.tgz

RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list \
 && echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list \
 && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add \
 && apt-get update && apt-get upgrade -y -qq && apt-get install sbt -y -qq \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

ENV SPARK_HOME='/spark-3.1.1-bin-hadoop2.7'
ENV PATH=$SPARK_HOME:$PATH
ENV PYTHONPATH=$SPARK_HOME/python:$PYTHONPATH

EXPOSE 8888 6006 4040

WORKDIR /notebooks

CMD ["jupyter", "notebook","--ip","0.0.0.0", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]