# Notes for Lessons Learned and Exit for Structures/Mobex meeting

The following is in Markdown format. It can be viewed better from https://markdownlivepreview.com/ by copying and pasting the contents below.

## Purpose

To make some recommendations for the lessons learned meeting.

## Players

- Adrian Wise
- Kristian Smith
- Kiran Ambati
- Aamir Ghaffar
- Christian Trujillo
- Brent Hall

## Network Recommendations

Division of labor to avoid bottlenecks.

  ### Corporate Network Architect

  - Overseer and maker of global network policies.
  - Not responsible for making network changes.
  - Constant review of all network changes corporate and division network engineers made.

  ### Corporate Network Engineer

  - Implements network policies of Network Architects at the global level.
  - Handles daily requests of division network engineers.

  ### Division Network Engineer

  - Implements network policies of the Network Architect at the division level.
  - Handles daily requests of network end-users.

### **[Linus Platform Engineer](https://platformengineering.org/blog/what-is-platform-engineering)** 

- Research and make recommendations to improve Kubernetes (K8s) platform reliability.
- Use an On-Prem K8s cluster for research and testing.
- Prove **[security](https://www.infracloud.io/blogs/request-level-authentication-authorization-istio-keycloak/)**
 and reliability of a Managed Kubernetes Service such as **[Azure Kubernetes Service (AKS), 2nd best Kubernetes platform](https://azure.microsoft.com/en-gb/products/kubernetes-service)**
.
- Responsible for **[Site Reliability Engineering (SRE)](https://aws.amazon.com/what-is/sre/#:~:text=Site%20reliability%20engineering%20(SRE)%20teams%20collect%20critical%20information%20that%20reflects,application%20responds%20to%20a%20request.)**

### **[Azure Architect](https://platformengineering.org/blog/what-is-platform-engineering)**

- Research and standardize departmental software using resources such as **[Windows 11 Enterprise multi-session remote desktops](https://learn.microsoft.com/en-us/mem/intune/fundamentals/azure-virtual-desktop-multi-session)** and **[Azure File Shares](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-introduction#why-azure-files-is-useful)**.
- Works with Azure Platform Engineer analyzing division software.

### **[Azure Platform Engineer](https://platformengineering.org/blog/what-is-platform-engineering)**

- Create and manage Azure resources as directed by Azure Architect.
- Works with division departments cataloging division software.
