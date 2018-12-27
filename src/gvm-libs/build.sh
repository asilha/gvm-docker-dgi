# Install gvm-libs
APP="gvm-libs"
CHECKOUT="b271a6cf76c938b938574a4fc7d862efe88c3239"

git clone https://github.com/greenbone/${APP}.git \
&& cd ${APP} \
&& git checkout ${CHECKOUT} . \
&& mkdir -p build \
&& cd build \
&& cmake .. \
&& make \
&& make install
