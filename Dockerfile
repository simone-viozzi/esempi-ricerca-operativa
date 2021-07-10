FROM python:3.9.6-slim-buster

ARG DEBIAN_FRONTEND="noninteractive"
ENV TZ="America/New_York"
RUN echo "deb http://ftp.de.debian.org/debian sid main" >> /etc/apt/sources.list
RUN sed -i -e's/ main/ main contrib non-free/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install --no-install-recommends git subversion gcc g++ make wget gfortran patch pkg-config file
RUN apt-get -y install --no-install-recommends libgfortran-10-dev libblas-dev liblapack-dev libmetis-dev libnauty2-dev
RUN apt-get -y install --no-install-recommends ca-certificates
RUN apt-get -y install gcc g++ gfortran git patch wget pkg-config liblapack-dev libmetis-dev


RUN apt-get install -y gcc \ 
                       libglpk-dev \
                       glpk-utils \
                       texlive-xetex \
                       texlive-fonts-recommended \
                       texlive-latex-recommended \
                       pandoc \
                       texlive \
                       latexmk \
                       coinor-cbc \
                       libx11-dev \
                       tk \
                       python3-tk \
                       python3-matplotlib \
                       coinor-libipopt-dev \ 
                       --install-recommends

RUN mkdir -p /usr/src/app/share

WORKDIR /usr/src/app/share     

RUN wget https://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.9.tgz
RUN gunzip Ipopt-3.12.9.tgz
RUN tar xvf Ipopt-3.12.9.tar
RUN mv Ipopt-3.12.9 CoinIpopt

WORKDIR /usr/src/app/share/CoinIpopt/ThirdParty/Blas
RUN ./get.Blas

WORKDIR /usr/src/app/share/CoinIpopt/ThirdParty/ASL
RUN ./get.ASL

# WORKDIR /usr/src/app/share/CoinIpopt/ThirdParty/Mumps
# RUN ./get.Mumps

WORKDIR /usr/src/app/share/CoinIpopt/ThirdParty/Metis
RUN ./get.Metis

WORKDIR /usr/src/app/share/CoinIpopt

RUN mkdir -p /usr/src/app/share/CoinIpopt/build

WORKDIR /usr/src/app/share/CoinIpopt/build

RUN ../configure

RUN make

#RUN make test
RUN make install
RUN make distclean
RUN ldconfig
RUN rm -rf /usr/src/app/share/Ipopt-3.12.9.tgz

ENV PATH="${PATH}:/usr/src/app/share/CoinIpopt/build/bin"

RUN pip install --no-input  glpk \
                            Cython \
                            numpy \
                            Pyomo \
                            ipykernel \
                            pylint \
                            nbconvert \
                            pandas \
                            matplotlib \
                            scipy \
                            ipython \
                            jupyter \
                            sympy \
                            nose \
                            requests


ENV PATH="${PATH}:~/.local/bin"

ARG USER_ID
ARG GROUP_ID

RUN useradd --create-home --shell /bin/bash user
USER user

CMD [ "bash" ]