# Docker Host NGINX Configuration

Use the `domain.conf` file in this folder to configure NGINX on the Docker Host.

## Code explanation

### Reverse Proxy

A reverse proxy is a server that sits between client devices and a web server, forwarding client requests to the web server and returning the server’s responses back to the clients. In the provided Nginx configuration, a reverse proxy is set up for the domain wp.awsl.melvincv.com to forward requests to a server running on localhost:8000.

Here’s how it works:

The listen 80; directive tells Nginx to listen for incoming HTTP traffic on port 80.

The server_name wp.awsl.melvincv.com; directive specifies that this server block should handle requests for the domain wp.awsl.melvincv.com.

The location / { ... } block defines how requests for the root path / and its sub-paths should be handled.

Within the location / { ... } block, the proxy_pass http://localhost:8000; directive tells Nginx to forward incoming requests to a server running on localhost:8000.

The proxy_set_header directives are used to pass information about the original request to the proxied server, such as the original host, IP address, and forwarding address.

This configuration sets up a basic reverse proxy that forwards requests for the domain wp.awsl.melvincv.com to a server running on localhost:8000. Additional settings, such as gzip compression and caching, can be added to further optimize the performance of the reverse proxy.

Three HTTP headers are sent to the proxied server:

1. `proxy_set_header Host $host;` sets the value of the `Host` header to the value of the `$host` variable, which contains the hostname from the request line.

2. `proxy_set_header X-Real-IP $remote_addr;` sets the value of the `X-Real-IP` header to the value of the `$remote_addr` variable, which contains the IP address of the client.

3. `proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;` sets the value of the `X-Forwarded-For` header to the value of the `$proxy_add_x_forwarded_for` variable, which contains the client's IP address and any intermediate proxy servers' IP addresses.

These headers are used to pass information about the original request to the proxied server. The `Host` header is used by virtual hosts to determine which server block should handle the request. The `X-Real-IP` and `X-Forwarded-For` headers are used to pass the client's IP address to the proxied server, which can be useful for logging or access control.

### Gzip compression

Here's an explanation of the gzip settings in the provided Nginx configuration:

1. `gzip on;` - This directive enables or disables gzip compression. In this case, it's turned on.

2. `gzip_vary on;` - This directive controls whether or not the "Vary: Accept-Encoding" header should be sent in a response. This header is used to tell proxies that they should cache two versions of the resource: one compressed, and one uncompressed. This is useful for situations where some clients support gzip and others do not.

3. `gzip_min_length 10240;` - This directive sets the minimum length of a response that will be compressed. In this case, responses with a length of at least 10KB will be compressed.

4. `gzip_proxied expired no-cache no-store private auth;` - This directive controls which types of proxied requests will be compressed. In this case, responses to requests that have an "expired", "no-cache", "no-store", "private", or "auth" Cache-Control header will be compressed.

5. `gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml;` - This directive specifies which MIME types of responses will be compressed. In this case, responses with a MIME type of text/plain, text/css, text/xml, text/javascript, application/x-javascript, or application/xml will be compressed.

6. `gzip_disable "MSIE [1-6]\.";` - This directive specifies which user agents should not receive compressed responses. In this case, clients with a user agent string that matches the regular expression "MSIE [1-6]\." (i.e., Internet Explorer versions 1 through 6) will not receive compressed responses.

### Static File Caching

This configuration sets up caching for static files (jpg, jpeg, png, gif, ico, css, js) with a max-age of 1 day (86400 seconds) using the Cache-Control header.

Remember to check the Nginx configuration for syntax errors with `sudo nginx -t` and reload the Nginx service with `sudo systemctl reload nginx` after making changes.
