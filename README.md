# Testing out some systemd script ideas

This is to overcome an issue faced where we need Google application credentials written safely to the file-system. The credentials are stored in AWS Secrets manager and we are using the [cps-secret-writer](https://github.com/bbc/cps-secret-writer) to do the work of getting those & writing them somewhere - the problem is when that call is made. We cannot do this pre-build as this will result in plain-text credentials being packaged up.

One solution is to request the credentials after the system has started by invoking via a systemd service. Since the server is a long running process, we will need to test whether a check for Google credentials (the `GOOOGLE_APPLICATION_CREDENTIALS`) happens at each request or only at startup. We should be able to add some logic around that to cause it to fail gracefully and retry in the circumstance that a request is made before the credentials file exists. The application can run without these calls so we need to ensure that a failure in this service does not result in a wider failure.

I have included a naive bake-script example. Much of the work currently happening in there _could_ move to the spec file for the application however, that might not be the logical place for it to live since this is, essentially, infrastructure; not application / business logic. One for discussion with the wider team.

## Basic Steps

1. Make the service executable

```bash
chmod +x ../foo.service
```

2. copy the sevice file to `/etc/systemd/system/`

```bash
cp ../foo.service /etc/systemd/system/foo.service
```

3. Make a directory for your app and move all the stuff you need in there

```bash
mkdir -p /usr/lib/foo/
cp -R . /usr/lib/foo/
```

4. Add and specified Environment files you need (ours will need an AWS account number in order to execute)

```bash
cp ../foo.conf /usr/lib/foo/foo.conf
```

5. now enable and start the service

```bash
systemctl enable foo.service
systemctl start foo.service
```
We can omit the `systemctl start foo.service` if we expect a reboot (ie, an AWS image deployment)

ps...
this all worked and is all in use now!
