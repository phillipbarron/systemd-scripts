chmod +x ../foo.service
cp ../foo.service /etc/systemd/system/foo.service
mkdir -p /usr/lib/foo/
cp ../foo.conf /usr/lib/foo/foo.conf

systemctl enable foo.service
systemctl start foo.service
