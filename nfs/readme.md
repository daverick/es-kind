```bash
docker volume create --driver local \
      --opt type=nfs \
      --opt o=nfsvers=4,addr=nfs.example-domain.com,rw \
      --opt device=:/Users/davidricordel/Documents/elastic/nfs-server \
      volume-nfs
```

```bash
docker run -it --rm \
    --mount 'type=volume,source=volume-nfs,target=/app,volume-driver=local,volume-opt=type=nfs,volume-opt=device=:/var/docker-nfs,"volume-opt=o=addr=host.docker.internal,rw,nfsvers=4,async"' busybox
```