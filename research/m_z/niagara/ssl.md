# **[Creating and Signing an SSL Certificate using Niagara Certificate Management in Workbench](https://know.innon.com/creating-signing-ssl-certificate-niagara)**

This article is taken from the original Tridium one available on Niagara Central here: <https://www.niagara-community.com/s/article/Creating-and-Signing-an-SSL-Certificate-using-Niagara-Certificate-Management-in-Workbench>

The CA and Server Certificates can be created using the Certificate Management Tool. Alternatively you may choose to only create the Server Certificate using the Certificate Management Tool. Then generate a certificate signing request which is then sent to a well known signing authority to be signed and imported back into the station's 'User Key Store'.
Use this Knowledge Article for assistance in creating and signing a server certificate using Niagara Workbench, Certificate Management and Certificate Signer tool.

Terminology
Alternate Server Name in Workbench Certificate generation is the ‘Subject Alternative Name’.
Common Name (CN) also known as the Fully Qualified Domain Name (FQDN), is the characteristic value within a Distinguished Name. Typically, it is composed of Host Domain Name and looks like, "www.symantec.com" or "symantec.com".
Subject Alternative Name (SAN) is an extension to X.509 that allows various values to be associated with a security certificate using a subjectAltName field. These values are called Subject Alternative Names (SANs)

Certificate creation and signing
While working with the "Niagara Certificate Management" tool, all files created can be saved to the default ‘Cert Management’ folder that is created in the Niagara User Home.

Make sure you are in the correct Certificate Manager when creating a Certificate Authority (CA) or Server Certificate. If you are creating a CA that will be used for certificate signing you’ll want to use the Workbench Certificate Manger. If you are creating a Server Certificate for a station then you want to use that station’s Certificate Manager.

1. Using the Workbench Certificate Manager, create a CA that will be used to sign server certificates. The CA will reside in the Workbench User Key Store. The ‘Alias’ and ‘Common Name’ usually match and can be whatever name desired, making sure there are no spaces or special characters in the name. Make sure you remember the CA’s password which is needed when you sign certificates using the CA.

2. Next using the Niagara Station’s Certificate Manager (Same tool can be accessed under Platform Services or in Platform) create a new Server Certificate. The ‘Common Name’ and the ‘Alternative Server Name’ need to be entered. Note that Niagara automatically copies the first item in the list of the ‘Common Name’ over to the “Alternative Server Name’. These two entries are not required to match. Meaning, the IP address could be used as the ‘Common Name’ and the ‘Fully Qualified Computer Name’ could be used as the ‘Alternative Server Name’. Be aware that Niagara versions prior to version N4.8 must use the Fully Qualified Computer Name due to a problem using IP addresses. An example: Open 'System' on the computer and locate the 'Full computer name'. Use that for the ‘Common Name’ and the ‘Alternative Server Name’ in the server certificate. It could be something such as 'mycomputer.storedomain.com'.

3. After completing the creation of the Server Certificate you then must sign this certificate using the CA previously created. Select (highlight) that new server certificate and press the ‘Cert Request’ button to create a new certificate signing request (‘.csr’ file). You can save this ‘.csr’ file to the ‘Cert Management’ folder located in the User Home.

4. Use the Workbench Signer Tool to sign the Cert Request just created. You will browse to the ‘Cert Management’ folder and select the appropriate ‘.csr’ file. Also make sure to select the CA in the drop down that you created to use for signing. You will need to enter that CA's password.

5. Import the PEM file into the station's User Key Store. This will be the PEM that resulted from signing the server certificate’s Cert Request. Once the signed cert request has been imported, the server certificate (in the Station’s User Key Store) should have a green shield icon with check symbol. Also see: <https://www.niagara-community.com/articles/Knowledge/Importing-a-PEM-file-using-Workbench>

6. The new Server Certificate needs to be selected in the Web Service (Https Cert) and Fox Service (Foxs Cert).

7. To use this new server certificate in a browser you will need to import the CA (that was used to sign the server certificate) into a trust store on your computer.
a. If using Chrome or Internet Explorer, those browsers use the computer’s certificate store, so you can import the CA into the computer’s store using ‘certmgr.msc’. Typically you would import your CA into the ‘Trusted Root Certification Authorities’ location of the certificate store.
b. If using Firefox, that browser has its own certificate store and you should follow Firefox guidelines for importing a CA.
You should now be able to connect to the station securely using a browser and not receive any warning of the site being unsafe. Make sure to use ‘https://’ and also use the name (address) that was used in the ‘Alternate Server Name’.
