FROM python:3.9.6-slim-buster

RUN apt-get update && \
    apt-get install -y gcc \ 
                       libglpk-dev \
                       texlive-xetex \
                       texlive-fonts-recommended \
                       texlive-latex-recommended \
                       pandoc \
                       texlive \
                       latexmk


RUN pip install glpk \
                numpy \
                Pyomo \
                ipykernel \
                pylint \
                nbconvert

ENV PATH="${PATH}:~/.local/bin"

WORKDIR /root/workdir

CMD [ "bash" ]