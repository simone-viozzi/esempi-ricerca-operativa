FROM python:3.9.6-slim-buster

RUN apt-get update && \
    apt-get install -y gcc \ 
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
                       python3-matplotlib
                       


RUN pip install --no-input  glpk \
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