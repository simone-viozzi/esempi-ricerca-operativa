

docker build -t glpk \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) .