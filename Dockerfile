FROM julia:1.5.0
LABEL maintainer "Nobuyuki Matsui <nobuyuki.matsui@gmail.com>"

ARG PORT
ENV PORT ${PORT:-8000}

COPY Project.toml /opt
COPY src/* /opt/src/
WORKDIR /opt

RUN julia --project=/opt -e 'using Pkg; Pkg.instantiate()'
ENTRYPOINT julia --project=/opt /opt/src/main.jl

