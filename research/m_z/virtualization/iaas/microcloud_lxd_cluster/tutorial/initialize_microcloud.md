# **[How to initialise MicroCloud](https://documentation.ubuntu.com/microcloud/stable/microcloud/how-to/initialise/)**

The **[initialisation process](https://documentation.ubuntu.com/microcloud/stable/microcloud/explanation/initialisation/#explanation-initialisation)** bootstraps the MicroCloud cluster. You run the initialisation on one of the machines, and it configures the required services on all of the machines that have been joined.

## Interactive configuration

If you run the initialisation process in interactive mode (the default), you are prompted for information about your machines and how you want to set them up. The questions that you are asked might differ depending on your setup; for example, if you do not have the MicroOVN snap installed, you will not be prompted to configure your network, and if your machines don’t have local disks, you will not be prompted to set up local storage.

The following instructions show the full initialisation process.

Tip

During initialisation, MicroCloud displays tables of entities to choose from.

To select specific entities, use the Up and Down keys to choose a table row and select it with the Space key. To select all rows, use the Right key. You can filter the table rows by typing one or more characters.

When you have selected the required entities, hit Enter to confirm.

Complete the following steps to initialise MicroCloud:

On one of the machines, enter the following command:

sudo microcloud init
