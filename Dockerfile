FROM gcc:7.2

ENV REFRESHED_AT 2018-06-15
ENV DOCKER_RUN 1

# Set up a tools dev directory
RUN mkdir /home/dev
# Pull the gcc-arm-none-eabi tarball and install it
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2017q4/gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2 \
	&& tar xvf gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2 -C /home/dev \
	&& rm gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2
ENV PATH $PATH:/home/dev/gcc-arm-none-eabi-7-2017-q4-major/bin
RUN arm-none-eabi-gcc --version

RUN apt-get -qq update \
	&& apt-get -y install git make python-pip bc

# Check that clang-format is working
RUN apt-get -y install clang-format

# Loading all the files from the repo to install the dependancies
# Copy of directories is independant to use caching as much as possible
# Here we copy only the files that are needed for docker build to complete
# Other files are copied at the end of this Dockerfile
WORKDIR /home/project
COPY util/pc-nrfutil /home/project/util/pc-nrfutil

RUN pip install -r /home/project/util/pc-nrfutil/requirements.txt --user
# We need dependancy, Six 1.11 (not correct in requirements.txt)
RUN pip install six==1.11 --user
RUN cd /home/project/util/pc-nrfutil/ && python setup.py install --user && cd -

# Check that nrfutil is working
ENV PATH $PATH:/root/.local/bin
RUN nrfutil version

# Set cross compiler path variable to find compiler using Makefiles
ENV CROSS_COMPILE /home/dev/gcc-arm-none-eabi-7-2017-q4-major

# Copy all the files of the project at the end to
# use Docker caching
COPY . /home/project/
