# Testing out some scripts-as-systemd service ideas

This is to overcome an issue faced where we need Google application credentials written safely to the file-system. The credentials are stored in AWS Secrets manager and we are using the [cps-secret-writer](https://github.com/bbc/cps-secret-writer) to do that work - the problem is when that call is made. We cannot do this pre - build as this will result in plain-text credentials being packaged up.

The solution is to request the credentials after the system has started by invoking via a systemd service. Since the server is a long running process, we will need to test whether a the check for credentials happens at each request or only at startup. We should be able to add some logic around that to cause it to fail gracefully and retry in the circumstance that a request is made before the credentials file exists. The application can run without these calls so we need to ensure that a failure in this service does not result in a wider failure.

I have included a naieve bake-script example. Much of the work currently happening in there _could_ move to the spec file for the application however, that might not be the logical place for it to live since this is, essentially, infrastruct, not application / business logic. One for sicussion with the wider team.
