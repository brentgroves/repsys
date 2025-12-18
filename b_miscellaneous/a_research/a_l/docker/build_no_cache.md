# **[How to build an image without the Docker cache](https://www.linkedin.com/pulse/how-build-image-without-docker-cache-razorops/)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

Building Docker images as fast as possible is essential. The quicker you can build an image, the more quickly you can test it and deploy it to production. Docker's build cache is a great way to speed up builds by reusing layers from previous builds.

To build a Docker image without using the cache, you can use the ‘--no-cache’ flag with the ‘docker build’ command. This flag tells Docker to ignore any cached layers during the build process.

Open a terminal or command prompt and navigate to the directory containing your Dockerfile.

Run the following command to build the Docker image without the cache:

```bash
docker build --no-cache -t <image-name> .
```

Replace ‘<image-name>’ with the desired name for your Docker image.

Docker will start the build process, ignoring the cache for each step defined in your Dockerfile. It will download any required dependencies and rebuild all the layers from scratch.

Wait for the build process to complete. This may take longer than a regular build since all layers are being rebuilt without leveraging any cached layers.

Once the build is finished, you will have a Docker image created without any cache layers. You can verify it by running ‘docker images’ and checking for the ‘<image-name>’ in the list.

By building an image without using the Docker cache, you can ensure that all layers are rebuilt, which can be beneficial when you want to guarantee a clean and up-to-date image, especially if your dependencies or build environment have changed.

building without the cache may result in longer build times, especially if your image has many layers or dependencies. Use this approach judiciously based on your specific requirements and the trade-off between build time and ensuring a completely fresh image.

## How Docker caching works

Docker caching is a mechanism that improves the efficiency and speed of building Docker images. It leverages the concept of layers, where each instruction in a Dockerfile creates a separate layer in the final image. Here's a detailed explanation of how Docker caching works:

**Layer-based Architecture:** Docker images are built using a layered architecture. Each instruction in a Dockerfile, such as copying files, installing packages, or running commands, creates a new layer. These layers are stacked on top of each other to form the final image. Each layer represents a specific change or modification to the filesystem.

**Caching Mechanism:** When you build a Docker image, Docker tries to use the cache to speed up the process. It compares each instruction in the Dockerfile with the existing cache to determine if it can reuse any previously built layers. If a layer's context (the files and directories it depends on) hasn't changed, Docker uses the cached layer instead of rebuilding it. This significantly reduces the build time, as unchanged layers don't need to be recreated.

**Cache Invalidation:** Docker determines whether a layer needs to be rebuilt or fetched from the cache based on a checksum of the instruction and its context. If any of these change, Docker considers the layer invalid and rebuilds it and all subsequent layers. This ensures that changes to instructions or the context are accurately reflected in the final image.

**Building with Cache:** When you initially build an image, Docker builds and caches each layer in the image. Subsequent builds of the same image, or builds that use the same base image and unchanged layers, benefit from the cache. Docker reuses the existing cached layers, speeding up the build process significantly. This is especially beneficial during development when only a few layers or instructions have changed.

**Building without Cache:** Sometimes, you may want to build an image without relying on the cache. This can be useful when you want to ensure a clean build, update all layers due to changes in dependencies or build environment, or avoid potential caching issues. By using the ‘--no-cache’ flag with the ‘docker build’ command, Docker ignores the cache and rebuilds all layers from scratch.

Docker caching helps optimise image builds and reduces build times. By utilising the cache effectively, you can benefit from faster iterations during development while ensuring that changes are accurately reflected in the final image.

## Building an image without the cache using --no-cache

To build a Docker image without using the cache, you can utilise the ‘--no-cache’ flag with the ‘docker build’ command. This approach ensures that all layers are rebuilt from scratch, regardless of any cached layers. Here's a step-by-step guide:

Open a terminal or command prompt and navigate to the directory containing your Dockerfile.

Run the following command to build the Docker image without the cache:

`docker build --no-cache -t <image-name> .`

Replace ‘<image-name>’ with the desired name for your Docker image.

Docker will initiate the build process, bypassing the cache for each instruction in the Dockerfile. It will rebuild all the layers from scratch, ensuring a completely fresh image.

Allow the build process to complete. Note that building without the cache may take longer than usual, as all layers are being rebuilt without the benefit of any cached layers.

Once the build is finished, you will have a Docker image created without utilising any cache layers. You can verify the newly built image by running ‘docker images’ and locating the ‘<image-name>’ in the list.

Building an image without the cache using the ‘--no-cache’ flag is useful in scenarios where you want to ensure that all layers are rebuilt from scratch, such as when you need to update dependencies or configurations that may have an impact on the image's integrity. However, it's worth noting that building without the cache can result in longer build times compared to using cached layers. Therefore, it's recommended to use this approach judiciously, considering the trade-off between a completely fresh image and build time efficiency. Follow RazorOps Linkedin Page Razorops, Inc.
