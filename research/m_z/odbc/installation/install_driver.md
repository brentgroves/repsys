# **[Install the Microsoft ODBC driver for SQL Server (Linux)](https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver17&tabs=alpine18-install%2Calpine17-install%2Cdebian8-install%2Credhat7-13-install%2Crhel7-offline)**

This article explains how to install the Microsoft ODBC Driver for SQL Server on Linux. It also includes instructions for the optional command-line tools for SQL Server (bcp and sqlcmd) and the unixODBC development headers.

This article provides commands for installing the ODBC driver from the bash shell. If you want to download the packages directly, see Download ODBC Driver for SQL Server.

## Microsoft ODBC 18

The following sections explain how to install the Microsoft ODBC driver 18 from the bash shell for different Linux distributions. Supported distributions are Alpine Linux, Debian, Red Hat Enterprise Linux (RHEL), Oracle Linux, SUSE Linux Enterprise Server (SLES), and Ubuntu. Starting with version 18.4, to accept the EULA automatically when installing the non-Alpine Linux (.deb or .rpm) driver, you can create the file '/opt/microsoft/msodbcsql18/ACCEPT_EULA'.

```bash
if ! [[ "20.04 22.04 24.04 24.10" == *"$(grep VERSION_ID /etc/os-release | cut -d '"' -f 2)"* ]];
then
    echo "Ubuntu $(grep VERSION_ID /etc/os-release | cut -d '"' -f 2) is not currently supported.";
    exit;
fi

# Download the package to configure the Microsoft repo
curl -sSL -O https://packages.microsoft.com/config/ubuntu/$(grep VERSION_ID /etc/os-release | cut -d '"' -f 2)/packages-microsoft-prod.deb
# Install the package
sudo dpkg -i packages-microsoft-prod.deb
# Delete the file
rm packages-microsoft-prod.deb

# Install the driver
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18
# optional: for bcp and sqlcmd
sudo ACCEPT_EULA=Y apt-get install -y mssql-tools18
echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
source ~/.bashrc
# optional: for unixODBC development headers
sudo apt-get install -y unixodbc-dev
