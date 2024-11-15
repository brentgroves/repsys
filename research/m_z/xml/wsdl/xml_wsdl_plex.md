# **[XML WSDL](https://www.w3schools.com/xml/xml_wsdl.asp)**

- **[Current Status](../../../../development/status/weekly/current_status.md)**\
- **[Research List](../../../../research/research_list.md)**\
- **[Back Main](../../../../README.md)**

## references

- **[Restriction/Facets](../xsd/xml_restrictions.md)**
- **[Plex](../../../../../secrets/plex/windows_odbc_connection.md)**
- Is an XSD for Web Services
- WSDL stands for Web Services Description Language
- WSDL is used to describe web services
- WSDL is written in XML
- WSDL is a W3C recommendation from 26. June 2007

## WSDL Documents

An WSDL document describes a web service. It specifies the location of the service, and the methods of the service, using these major elements:

| Element    | Description                                                               |
|------------|---------------------------------------------------------------------------|
| ```<types>```    | Defines the (XML Schema) data types used by the web service               |
| ```<message>```  | Defines the data elements for each operation                              |
| ```<portType>``` | Describes the operations that can be performed and the messages involved. |
| ```<binding>```  | Defines the protocol and data format for each port type                   |

## Complex Types

ComplexTypes defined in the <http://www.plexus-online.com/DataSource> schema and referenced in Plex_SOAP_prod.wsdl that are used to call the Account_Activity_Summary_xPCN_Get Plex web service

Note: Dont have access to the <http://www.plexus-online.com/DataSource> schema, but do have access to the Plex wsdl file.

```xml
      <s:complexType name="ExecuteDataSourceRequest">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="DataSourceKey" type="s:string"/>
          <s:element minOccurs="0" maxOccurs="1" name="InputParameters" type="tns:ArrayOfInputParameter"/>
          <s:element minOccurs="0" maxOccurs="1" name="DataSourceName" type="s:string"/>
          <s:element minOccurs="0" maxOccurs="1" name="DataBase" type="s:string"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="ArrayOfInputParameter">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="unbounded" name="InputParameter" nillable="true" type="tns:InputParameter"/>
        </s:sequence>
      </s:complexType>
      <s:complexType name="InputParameter">
        <s:complexContent mixed="false">
          <s:extension base="tns:Parameter">
            <s:sequence>
              <s:element minOccurs="1" maxOccurs="1" name="Required" type="s:boolean"/>
              <s:element minOccurs="1" maxOccurs="1" name="Output" type="s:boolean"/>
              <s:element minOccurs="0" maxOccurs="1" name="DefaultValue" type="s:string"/>
              <s:element minOccurs="0" maxOccurs="1" name="Message" type="s:string"/>
            </s:sequence>
          </s:extension>
        </s:complexContent>
      </s:complexType>
      
```

### SimpleTypes defined in the <https://www.w3.org/2001/XMLSchema> schema and referenced by the <http://www.plexus-online.com/DataSource> schema

```xml
<xs:simpleType name="string" id="string">
<xs:annotation>
<xs:appinfo>
<hfp:hasFacet name="length"/>
<hfp:hasFacet name="minLength"/>
<hfp:hasFacet name="maxLength"/>
<hfp:hasFacet name="pattern"/>
<hfp:hasFacet name="enumeration"/>
<hfp:hasFacet name="whiteSpace"/>
<hfp:hasProperty name="ordered" value="false"/>
<hfp:hasProperty name="bounded" value="false"/>
<hfp:hasProperty name="cardinality" value="countably infinite"/>
<hfp:hasProperty name="numeric" value="false"/>
</xs:appinfo>
<xs:documentation source="http://www.w3.org/TR/xmlschema-2/#string"/>
</xs:annotation>
<xs:restriction base="xs:anySimpleType">
<xs:whiteSpace value="preserve" id="string.preserve"/>
</xs:restriction>
</xs:simpleType>
```

```python
  # https://docs.python-zeep.org/en/master/transport.html?highlight=authentication#http-authentication
  session = Session()
  session.auth = HTTPBasicAuth(username4,password4)
  # session.auth = HTTPBasicAuth('MGEdonReportsws@plex.com','9f45e3d-67ed-')

  client = Client(wsdl='../wsdl/Plex_SOAP_prod.wsdl',transport=Transport(session=session)) # prod
#%DEV%client = Client(wsdl='/home/brent/src/Reporting/prod/volume/wsdl/Plex_SOAP_prod.wsdl',transport=Transport(session=session)) # stand-alone .
  
  # https://docs.python-zeep.org/en/master/datastructures.html
  e_type = client.get_type('ns0:ExecuteDataSourceRequest')
  a_ip_type = client.get_type('ns0:ArrayOfInputParameter')
  ip_type=client.get_type('ns0:InputParameter')
  ip_pcn = ip_type(Value=pcn,Name='@PCNs',Required=False,Output=False)


  while period <= end_open_period:
    ip_period_start = ip_type(Value=period,Name='@Period_Start',Required=True,Output=False)
    ip_period_end = ip_type(Value=period,Name='@Period_End',Required=True,Output=False)
    Parameters=a_ip_type([ip_pcn,ip_period_start,ip_period_end])

    # e=e_type(DataSourceKey=8619,InputParameters=[{'Value':'4/26/2022','Name':'@Report_Date','Required':False,'Output':False}],DataSourceName='Detailed_Production_Get_New')
    e=e_type(DataSourceKey=4814,InputParameters=Parameters,DataSourceName='Account_Activity_Summary_xPCN_Get')

    response = client.service.ExecuteDataSource(e)
```

# **[XML WSDL](https://www.w3schools.com/xml/xml_wsdl.asp)**

- **[Current Status](../../../../development/status/weekly/current_status.md)**\
- **[Research List](../../../../research/research_list.md)**\
- **[Back Main](../../../../README.md)**

## references

- **[Restriction/Facets](../xsd/xml_restrictions.md)**

- Is an XSD for Web Services
- WSDL stands for Web Services Description Language
- WSDL is used to describe web services
- WSDL is written in XML
- WSDL is a W3C recommendation from 26. June 2007

## WSDL Documents

An WSDL document describes a web service. It specifies the location of the service, and the methods of the service, using these major elements:

| Element    | Description                                                               |
|------------|---------------------------------------------------------------------------|
| ```<types>```    | Defines the (XML Schema) data types used by the web service               |
| ```<message>```  | Defines the data elements for each operation                              |
| ```<portType>``` | Describes the operations that can be performed and the messages involved. |
| ```<binding>```  | Defines the protocol and data format for each port type                   |

```xml
The main structure of a WSDL document looks like this:

<definitions>

<types>
  data type definitions........
</types>

<message>
  definition of the data being communicated....
</message>

<portType>
  set of operations......
</portType>

<binding>
  protocol and data format specification....
</binding>

</definitions>
```

WSDL Example
This is a simplified fraction of a WSDL document:

```xml
<message name="getTermRequest">
  <part name="term" type="xs:string"/>
</message>

<message name="getTermResponse">
  <part name="value" type="xs:string"/>
</message>

<portType name="glossaryTerms">
  <operation name="getTerm">
    <input message="getTermRequest"/>
    <output message="getTermResponse"/>
  </operation>
</portType>
```

In this example the ```<portType>``` element defines "glossaryTerms" as the name of a port, and "getTerm" as the name of an operation.

The "getTerm" operation has an input message called "getTermRequest" and an output message called "getTermResponse".

The ```<message>``` elements define the parts of each message and the associated data types.

## The ```<portType>``` Element

The ```<portType>``` element defines a web service, the operations that can be performed, and the messages that are involved.

The request-response type is the most common operation type, but WSDL defines four types:

## Type Definition

- One-way The operation can receive a message but will not return a response
- Request-response The operation can receive a request and will return a response
- Solicit-response The operation can send a request and will wait for a response
- Notification The operation can send a message but will not wait for a response

## WSDL One-Way Operation

A one-way operation example:

```xml
<message name="newTermValues">
  <part name="term" type="xs:string"/>
  <part name="value" type="xs:string"/>
</message>

<portType name="glossaryTerms">
  <operation name="setTerm">
    <input name="newTerm" message="newTermValues"/>
  </operation>
</portType >
```

In the example above, the portType "glossaryTerms" defines a one-way operation called "setTerm".

The "setTerm" operation allows input of new glossary terms messages using a "newTermValues" message with the input parameters "term" and "value". However, no output is defined for the operation.

## WSDL Request-Response Operation

A request-response operation example:

```xml
<message name="getTermRequest">
  <part name="term" type="xs:string"/>
</message>

<message name="getTermResponse">
  <part name="value" type="xs:string"/>
</message>

<portType name="glossaryTerms">
  <operation name="getTerm">
    <input message="getTermRequest"/>
    <output message="getTermResponse"/>
  </operation>
</portType>
```

In the example above, the portType "glossaryTerms" defines a request-response operation called "getTerm".

The "getTerm" operation requires an input message called "getTermRequest" with a parameter called "term", and will return an output message called "getTermResponse" with a parameter called "value".

## WSDL Binding to SOAP

WSDL bindings defines the message format and protocol details for a web service.

A request-response operation example:

```xml
<message name="getTermRequest">
  <part name="term" type="xs:string"/>
</message>

<message name="getTermResponse">
  <part name="value" type="xs:string"/>
</message>

<portType name="glossaryTerms">
  <operation name="getTerm">
    <input message="getTermRequest"/>
    <output message="getTermResponse"/>
  </operation>
</portType>

<binding type="glossaryTerms" name="b1">
   <soap:binding style="document"
   transport="http://schemas.xmlsoap.org/soap/http" />
   <operation>
     <soap:operation soapAction="http://example.com/getTerm"/>
     <input><soap:body use="literal"/></input>
     <output><soap:body use="literal"/></output>
  </operation>
</binding>
```

The binding element has two attributes - name and type.

The name attribute (you can use any name you want) defines the name of the binding, and the type attribute points to the port for the binding, in this case the "glossaryTerms" port.

The soap:binding element has two attributes - style and transport.

The style attribute can be "rpc" or "document". In this case we use document. The transport attribute defines the SOAP protocol to use. In this case we use HTTP.

The operation element defines each operation that the portType exposes.

For each operation the corresponding SOAP action has to be defined. You must also specify how the input and output are encoded. In this case we use "literal".
