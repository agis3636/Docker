# Docker Compose

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

                BUAT FILE DOCKER COMPOSE

buat file dengan nama "docker-compose.yaml"

    services:
      nginx-example:
        container_name: nginx-example
        image: nginx:latest

---

                MEMBUAT CONTAINER
                
untuk membuat Container, harus masuk ke dalam directory yang menyimpan file "docker-compose.yaml"

    docker compose create
    docker container ls -a

---

mau bikin lagi ?

    services:
        nginx-example:
            container_name: nginx-example
            image: nginx:latest
        nginx-example2:
            container_name: nginx-example2
            image: nginx:latest

---

untuk membuat Container, harus masuk ke dalam directory yang menyimpan file "docker-compose.yaml"

    docker compose create
    docker container ls -a

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

                JALANKAN CONTAINER

    docker compose start
    docker container ls

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

                MELIHAT CONTAINER

jalankan dulu container yang dibuat selain menggunakan compose

    docker compose ps


--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

                MENGHENTIKAN CONTAINER

    docker compose stop

ini hanya menghentikan container yang di setting dari compose saja, yang bukan dari compose ga mati

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

                MENGHAPUS CONTAINER

coba di start dulu composenya. karna bedanya kalo kita pakai docker compose, ketika di hapus composenya dia bisa langsung terhapus tanpa harus di matikan dulu compose nya

    docker compose start
    docker compose down
    docker compose ps -a
    docker container ls -a

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

                PROJECT NAME

      docker compose ls
    docker compose create
    docker compose start
      docker compose ls
    docker compose down

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

                SERVICES

buat file dengan nama "docker-compose.yaml"

    services:
      nginx-example:
        image: nginx:latest
        container_name: nginx-example
      mongodb-example:
        image: mongo:latest
        container_name: mongodb-example
        
---

jalankan compose

masuk dulu ke direktory tujuan

    docker compose create
    docker compose start

    docker compose down
    
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
             
                KOMENTAR

buat file dengan nama "docker-compose.yaml"

    services:
    
      # this is example nginx
      nginx-example:
        image: nginx:latest
        container_name: nginx-example
        
      # this is example mongo
      mongodb-example:
        image: mongo:latest
        container_name: mongodb-example
        
---

jalankan compose

masuk dulu ke direktory tujuan

    docker compose create
    docker compose start

    docker compose down

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
             
                PORT

buat file dengan nama "docker-compose.yaml"

    services:
    
      # ini yang long port   
      nginx-port1:
        image: nginx:latest
        container_name: nginx-port1  
        ports:
          - protocol: tcp
            published: 8080
            target: 80
    
      # ini yang short port  
      nginx-port2:
        image: nginx:latest
        container_name: nginx-port2
        ports:
          - "8081:80"
        
---

jalankan compose

masuk dulu ke direktory tujuan

    docker compose create
    docker compose start
    docker compose ps

cek ip
    curl 192.168.80.175:8081
    curl 192.168.80.175:8081

    docker compose down

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
             
                ENVIRONMENT

buat file dengan nama "docker-compose.yaml"

    services:
     
      mongodb-example:
        image: mongo:latest
        container_name: mongodb-example  
        ports:
          - "27017:27017"
        environment:
          MONGO_INITDB_ROOT_USERNAME: agis
          MONGO_INITDB_ROOT_PASSWORD: rahasia
          MONGO_INITDB_DATABASE: admin
        
---

jalankan compose

masuk dulu ke direktory tujuan

    docker compose create
    docker compose start
    docker compose ps

cek ip
    curl 192.168.80.175:8081
    curl 192.168.80.175:8081

    docker compose down
