# **[Quarkus and GraalVM](https://quarkus.io/)**

**[Back to Research List](../../../research/research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## references

- **[wikipedia](https://en.wikipedia.org/wiki/Quarkus)**
- **[Quarkus](https://quarkus.io/)**
- **[GraalVM](https://www.oracle.com/java/graalvm/)**

## GraalVM

GraalVM is a high performance JDK that speeds up the performance of Java and JVM-based applications and simplifies the building and running of Java cloud native services. The optimized compiler generates faster code and uses fewer compute resources, enabling microservices to start instantly. GraalVM is included with the Java SE Universal Subscription at no additional cost.

## Quarkus

Quarkus is a Java framework tailored for deployment on Kubernetes. Key technology components surrounding it are OpenJDK HotSpot and GraalVM. Wikipedia

## Container first

Quarkus tailors your application for GraalVM and HotSpot. Amazingly fast boot time, incredibly low RSS memory (not just heap size!) offering near instant scale up and high density memory utilization in container orchestration platforms like Kubernetes. We use a technique we call compile time boot.
