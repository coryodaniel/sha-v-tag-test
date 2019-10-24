# kubelet image "present" check

Kubernetes docs dont mention how a kubelet determines if a docker image is 'present' on the node, by digest SHA or docker tag.

This repo makes two docker builds tagging them with both with latest and `0.1`. The first image is also tagged 0.1.1, while the second is tagged 0.1.2.

The k8s deployments both using image tag `0.1`. As you build, tag, and push each image after deployment you can see the version output change in the logs despite the image tag staying the same.

This shows that the kubelet determines presence based on digest SHA.

Terminal 1:

```bash
make log
```

Terminal 2:

```bash
make run
```
