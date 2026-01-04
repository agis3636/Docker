DOCKER HUB REGISTRY
------------------------------------------------------------------------------------------
  Token Belajar:
  
    dckr_pat_uaATiKsxAe64dCaFqrYl6TN4j3U
------------------------------------------------------------------------------------------
  Docker Login:
  
    docker login -u agis3636
    
    i Info → A Personal Access Token (PAT) can be used instead.
             To create a PAT, visit https://app.docker.com/settings
                        
    Password: 
    
    WARNING! Your credentials are stored unencrypted in '/home/agis/.docker/config.json'.
    Configure a credential helper to remove this warning. See
    https://docs.docker.com/go/credential-store/
    
    Login Succeeded
------------------------------------------------------------------------------------------
  Docker Push:
  
    docker push agis3636/image:v1.0
------------------------------------------------------------------------------------------
  kalau tidak pakai username gak akan bisa, akan muncul output seperti ini:
  
    denied: requested access to the resource is denied


=========================================================================================

=========================================================================================


DIGITAL OCEAN CONTAINER REGISTRY
------------------------------------------------------------------------------------------
https://cloud.digitalocean.com/registry?i=9e9c9b

https://www/digitalocean.com/products/container-registry

  <img width="1352" height="627" alt="Image" src="https://github.com/user-attachments/assets/b96341f0-66f3-4c1d-97ba-45e90097d42c" />

  <img width="1353" height="644" alt="Image" src="https://github.com/user-attachments/assets/6ba0b84b-fa95-4d17-a6e9-a90188115ab2" />

  docker tag agis3636/image registry.digitalocean.com/agis/image
  
  docker--config /user/namapc-atau-user/.docker-digital-ocean/ push agis3636/image
