# Dehydrated Docker

[Dehydrated](https://github.com/dehydrated-io/dehydrated) client with [Cloudflare hook](https://github.com/walcony/letsencrypt-cloudflare-hook), run inside a Docker container.

## Installation

1. Create the following files:  
   **docker-compose.yml**
    ```YAML
    version: '3'
    services:
      certs:
        image: carlgo11/dehydrated-docker
        env_file:
          - .env
        volumes:
          - ./domains.txt:/tmp/domains.txt:ro
          - ./certs/:/persistent/certs
          - persistent:/persistent
        tmpfs:
          - /tmp
        read_only: true
        restart: unless-stopped

    volumes:
      persistent:
    ```

   **.env**
    ```shell
    CF_EMAIL=""
    CF_KEY=""
    CF_SETTLE_TIME=""
    CONTACT_EMAIL=""
    CA="letsencrypt"
    ```

1. Create the directory `certs`
   ```shell
   mkdir certs
   chown 1000:1000 certs
   ```

1. Create `domains.txt` and fill it the desired domains to create certificates for:
    ```text
    example.com
    sub.example.com
    ```

## Usage

* Manually run the script
   ```shell
   docker-compose up
   ```
* Run the script via a cron job
  ```crontab
  # Run at start of each month
  0 0 1 * * cd ${SCRIPT PATH}; docker-compose up 
  ```

## Configuration

| Name           | Example                                  | Description                             |
|----------------|------------------------------------------|-----------------------------------------|
| CA             | Letsencrypt                              | Certificate Authority name              |
| CF_EMAIL       | user@example.com                         | Cloudflare account email                |
| CF_KEY         | xxxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxx | Cloudflare API Key with DNS edit access |
| CF_SETTLE_TIME | 15                                       | Waiting delay                           |
| CONTACT_EMAIL  | user@example.com                         | CA registration email                   |
