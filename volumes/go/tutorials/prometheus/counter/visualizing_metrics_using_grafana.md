# visualizing_metrics_using_grafana

## references

<https://prometheus.io/docs/tutorials/visualizing_metrics_using_grafana/>

## **[Installing and Setting up Grafana](../../../../../linux/grafana/grafana-install.md)**

Install and Run Grafana by following the steps from **[here](https://grafana.com/docs/grafana/latest/installation/requirements/#supported-operating-systems)** for your operating system.

```bash
sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl status grafana-server
sudo systemctl stop grafana-server

```

Once Grafana is installed and run, navigate to <http://localhost:3000> in your browser. Use the default credentials, username as admin and password as admin to log in and setup new credentials. admin/prom-operator

Adding Prometheus as a Data Source in Grafana.
Let's add a datasource to Grafana by clicking on the gear icon in the side bar and select Data Sources

In the Data Sources screen you can see that Grafana supports multiple data sources like Graphite, PostgreSQL etc. Select Prometheus to set it up.

Enter the URL as <http://localhost:9090> under the HTTP section and click on Save and Test.

## Creating our first dashboard

Now we have succesfully added Prometheus as a data source, Next we will create our first dashboard for the ping_request_count metric that we instrumented in the previous tutorial.

1. Click on the + icon in the side bar and select Dashboard.
2. In the next screen, Click on the Add new panel button.
3. In the Query tab type the PromQL query, in this case just type ping_request_count.
4. Access the ping endpoint few times and refresh the Graph to verify if it is working as expected.
5. On the right hand section under Panel Options set the Title as Ping Request Count
6. Click on the Save Icon in the right corner to Save the dashboard.
