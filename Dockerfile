FROM docker.io/tgagor/centos-stream

LABEL maintainer="godmar@gmail.com"

RUN yum -y install gcc openssl-devel automake libtool git diffutils make procps
RUN dnf -y module install nodejs:16
RUN adduser user

USER user
COPY --chown=user:user src /home/user/src
COPY --chown=user:user react-app /home/user/react-app
COPY --chown=user:user install-dependencies.sh /home/user

WORKDIR /home/user
RUN sh install-dependencies.sh
WORKDIR /home/user/src
RUN make clean
RUN make
WORKDIR /home/user/react-app
RUN npm install
RUN npm run build
WORKDIR /home/user/react-app/build
RUN curl -o bunny.mp4 https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4
RUN cp -R /home/user/src/private /home/user/react-app/build

WORKDIR /home/user/src
CMD ./server -p 9999 -R ../react-app/build -a
