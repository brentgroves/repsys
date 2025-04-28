# Python package installer and repository index Network Config Request

Submitted : 2025-04-28 19:01:06
Request Number : REQ0200345

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/>> by copying and pasting the contents below.

Issue: The installation domain of **[Astal uv](https://astral.sh/blog/uv)**, the Python package installer and resolver, and the **[Pypi official third-party package index for the Python programming language](https://pypi.org/)** is blocked.

Project: Avilla Structures Kubernetes Cluster

Request: Please update the Avilla Structures "Kubernetes" policy to allow TCP access to **[Astal uv](https://astral.sh/blog/uv)** Python package installer and resolver, as well as the **[Pypi official third-party package index for the Python programming language](https://pypi.org/)**. **[Stack Overflow reference](https://stackoverflow.com/questions/14277088/what-url-should-i-authorize-to-use-pip-behind-a-firewall/67416056#67416056)**

Reason: Our existing **[ETL scripts](https://www.ibm.com/think/topics/etl#:~:text=ETL%E2%80%94meaning%20extract%2C%20transform%2C,lake%20or%20other%20target%20system.)** are developed in Python, and we need to install the language, tools, and packages so they can run.

Affected Application: Automated ETL and Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**

Business Justification: The Avilla Structures Kubernetes Cluster will be used to run Structures Information System software such as the Automated ETL and Report System, Tool Management System, and Tool Tracker Focused **[Manufacturing Execution System](https://www.ibm.com/think/topics/mes-system)**. These projects are for Linamar Structures but are currently directed toward Southfield, Albion, Avilla, and possibly Mills River.

## Requested Policy Change

Request TCP access to the installation domain of the **[Astal uv](https://astral.sh/blog/uv)** Python package installer and resolver as well the **[Pypi official third-party package repository index for the Python programming language](https://pypi.org/)** needed to install the language, tools, and packages to run our existing **[ETL scripts](https://www.ibm.com/think/topics/etl#:~:text=ETL%E2%80%94meaning%20extract%2C%20transform%2C,lake%20or%20other%20target%20system.)**.

## Key points about the firewall rule

- Protocol: TCP
- Port: 80/443
- Action: Allow
- Destinations:
  - astral.sh
  - *astral.sh
  - pypi.org
  - *pypi.org
  - pypi.python.org
  - *python.org
  - pythonhosted.org
  - *pythonhosted.org

## Verify

```bash
error: Failed to fetch: `https://pypi.org/simple/flask/`
  Caused by: Request failed after 3 retries
  Caused by: error sending request for url (https://pypi.org/simple/flask/)
  Caused by: operation timed out

curl -vv telnet://pypi.org:443

sudo tcpdump -i any -nn dst host pypi.org
# https://packaging.python.org/en/latest/tutorials/installing-packages/
```
