# Kong community

## references

<https://konghq.com/community>

```conf
# listening ports
proxy_listen = 0.0.0.0:8080
admin_listen = 0.0.0.0:8081

# enabled plugins
plugins = bundled, oidc
```

For the routing configuration, we’ll use the Kong declarative configuration in DB-less mode and provide a kong.yml yaml configuration file. In the configuration, we specify that our upstream api should be available beneath the path /oidc/, with the kong-oidc plugin applied:

```yaml
_format_version: "2.1"
_transform: true

services:
- name: oidc
  host:  upstream
  port: 80
  protocol: http
  plugins: 
  - name: oidc
    config: 
      discovery: http://host.docker.internal:9080/realms/test/.well-known/openid-configuration
      client_id: oidc-client
      client_secret: secret
  routes:
  - name: oidc-route
    paths:
    - /oidc/
    strip_path: true
```

The oidc plugin is configured with OIDC discovery url to Keycloak, as well as the client and secret to use. The /oidc/ path prefix will be removed before delegating to the upstream API.

Finally, we add the Kong gateway service to our docker compose file, which now looks like this:

```yaml
version: '3.9'

services:

  upstream:
    image: ealen/echo-server

  keycloak:
    image: quay.io/keycloak/keycloak
    ports:
      - "9080:9080"
    environment:
      KEYCLOAK_ADMIN: admin
      KEYCLOAK_ADMIN_PASSWORD: admin
    command: 
      - start-dev 
      - --db=dev-mem
      - --hostname=host.docker.internal
      - --http-port=9080
      - --import-realm
    volumes:
      - ./keycloak-test-realm.json:/opt/keycloak/data/import/realm.json

  kong:
    image: kong-with-plugins
    build:
      context: ./kong-with-plugins
    user: root
    volumes:
      - ./kong.yml:/etc/kong/kong.yml
      - ./kong.conf:/etc/kong/kong.conf
    environment:
      KONG_DATABASE: "off"
      KONG_DECLARATIVE_CONFIG: "/etc/kong/kong.yml"
    ports:
      - "8080:8080"
      - "8081:8081"
```

## TESTING THE OIDC FLOW

We are now ready to test the Kong Gateway in action. Start up the containers using docker compose in a terminal window:

```bash
pushd .
cd ~/src/blog-api-gateway-kong
docker compose up -d
```

Then open up a browser, and direct it to our API, via the Kong Gateway at <http://host.docker.internal:8080/oidc/api/>. You should be redirected to Keycloak for login.
