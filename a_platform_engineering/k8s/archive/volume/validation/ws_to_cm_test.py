# https://docs.python-zeep.org/en/master/
#import xmltodict
from zeep import Client
from zeep.transports import Transport

from requests import Session
from requests.auth import HTTPBasicAuth  # or HTTPDigestAuth, or OAuth1, etc.
import pyodbc
import os
import sys 
from datetime import datetime
import mysql.connector
from mysql.connector import Error
import logging.config


def print_to_stdout(*a):
    # Here a is the array holding the objects
    # passed as the argument of the function
    print(os.path.basename(__file__)+':',*a, file = sys.stdout)


def print_to_stderr(*a):
    # Here a is the array holding the objects
    # passed as the argument of the function
    print(os.path.basename(__file__)+':',*a, file = sys.stderr)

try:
  ret = 0
  # logging.basicConfig(level=logging.DEBUG)
  # https://geekflare.com/calculate-time-difference-in-python/
  start_time = datetime.now()
  end_time = datetime.now()

  current_time = start_time.strftime("%H:%M:%S")
  print_to_stdout(f"Current Time: {current_time=}")

  # https://docs.python-zeep.org/en/master/transport.html?highlight=authentication#http-authentication
  session = Session()
  # session.auth = HTTPBasicAuth('MGEdonReportsws@plex.com','9f45e3d-67ed-')
  session.auth = HTTPBasicAuth('BuscheAlbionWs2@plex.com','6afff48-ba19-')
  client = Client(wsdl='./volume/validation/Plex_SOAP_test.wsdl',transport=Transport(session=session))
  # https://docs.python-zeep.org/en/master/datastructures.html
  e_type = client.get_type('ns0:ExecuteDataSourceRequest')
  a_ip_type = client.get_type('ns0:ArrayOfInputParameter')
  ip_type=client.get_type('ns0:InputParameter')
  Report_Date=ip_type(Value='2022-04-28 08:00:00',Name='@Report_Date',Required=False,Output=False)
  End_Date=ip_type(Value='2022-04-28 08:59:59',Name='@End_Date',Required=False,Output=False)

  Parameters=a_ip_type([Report_Date,End_Date])

  # e=e_type(DataSourceKey=8619,InputParameters=[{'Value':'4/26/2022','Name':'@Report_Date','Required':False,'Output':False}],DataSourceName='Detailed_Production_Get_New')
  e=e_type(DataSourceKey=8619,InputParameters=Parameters,DataSourceName='Detailed_Production_Get_New')


  response = client.service.ExecuteDataSource(e)
  # print(response['OutputParameters'])

  # rs = response['ResultSets'].ResultSet[0].Rows.Row[0]
  # print(rs.Columns.Column[2].Value)
  # print(rs.Columns.Column[5].Value)
  # rec = [(rs.Columns.Column[2].Value,rs.Columns.Column[5].Value)]

  result = response['ResultSets'].ResultSet[0].Rows.Row
  length=len(result)
  # print("Length=% s" % length)
  # logging.debug("Length=% s" % length)

  # rs = response['ResultSets'].ResultSet[0].Rows.Row[0]

  # rec = [(rs.Columns.Column[2].Value,rs.Columns.Column[5].Value)]
  # rec.append((rs.Columns.Column[2].Value,rs.Columns.Column[5].Value))
  # print(rec)

  list = response['ResultSets'].ResultSet[0].Rows.Row
  print("Length=% s" % len(list))
  # Using for loop
  for i in list:
      column_names=""
      column_values=""
      dic ={}
      ind=0
      for j in i.Columns.Column:
        column_names=column_names+j.Name+','
        if j.Value is None:
          column_values=column_values+','  
        else:
          column_values=column_values+j.Value+','
        dic.update({j.Name:ind}) 
        # print(dic)
        # logging.debug(str(ind) + '-' + j.Name)
        # print(str(ind) + '-' + j.Name)
      # print(column_names)
        # word_freq.update({'before': 23})
        ind=ind+1
      # print(column_names)
      # print(column_values)
  # for i in list:
  #     for j in i.Columns.Column:
  #       print(j.Value)
      # print(i.Columns.Column[2].Name,i.Columns.Column[2].Value) part-key
      # print(i.Columns.Column[5].Name,i.Columns.Column[5].Value) 
  #     rec.append((306766,i.Columns.Column[2].Value,i.Columns.Column[5].Value))

  # print(rec)
  rs = response['ResultSets'].ResultSet[0].Rows.Row[0]
  PCN = 306766
  rec=[]
  # rec2=[]
  for i in list:
    # rec.append((rs.Columns.Column[0].Value))
    # rec = [(rs.Columns.Column[0].Value)]
    # rec.append((306766, '409615398','42712520', '2913697', '4/28/2022 8:32:15 AM'))
    rec.append((PCN,i.Columns.Column[18].Value,i.Columns.Column[1].Value,i.Columns.Column[2].Value,i.Columns.Column[9].Value))
    # rec.append((PCN,i.Columns.Column[18].Value,i.Columns.Column[1].Value,i.Columns.Column[2].Value,i.Columns.Column[9].Value))
  # rec.append((rs.Columns.Column[2].Value,rs.Columns.Column[5].Value))
    # print(rec)
    # logging.debug(rec)

  username = 'sa' 
  password = 'buschecnc1' 
  conn = pyodbc.connect('DSN=cm18;UID='+username+';PWD='+ password + ';TrustServerCertificate=yes;DATABASE=cribmaster')

  cursor = conn.cursor()

  #Sample select query
  # query ='''insert into Validation.Detailed_Production_History (pcn)
  # values (306766)'''
  # cursor.execute(query) 
  # cursor.commit()
  # query ='''insert into Validation.Detailed_Production_History (pcn,production_no)
  # values (306766,12)'''
  # cursor.execute(query) 
  # cursor.commit()
  # query ='''insert into Validation.Detailed_Production_History (pcn,production_no,part_no,part_key)
  # values (306766,12,'42712520', '2913697')'''
  # cursor.execute(query) 
  # cursor.commit()
  # query ='''insert into Validation.Detailed_Production_History (pcn,production_no,part_no,part_key,record_date)
  # values (306766, '409615398','42712520', '2913697', '4/28/2022 8:32:15 AM')'''
  # cursor.execute(query) 
  # cursor.commit()
# (306766, '409615398', 'H2GC 5K652 AB', '2684943', '4/28/2022 8:19:09 AM')

  im ='''insert into Validation.Detailed_Production_History (pcn,production_no)
  values (?,?)'''
  # im ='''insert into Validation.Detailed_Production_History (pcn,production_no)
  # values (?,?)'''
# insert into Validation.Detailed_Production_History (pcn,production_no,part_no,part_key,record_date)
# values (306766, 12,'42712520', '2913697', '4/28/2022 8:32:15 AM')
  ins ='''insert into Validation.Detailed_Production_History (pcn,production_no,part_no,part_key,record_date)
  values (?,?,?,?,?)'''
  print(ins)
  # cursor.fast_executemany = True

  # ls = [(306766, 12),(306766, 12)]
  # ls = [(306766, '409615398'),(306766, '409615398')]
  # cursor.executemany(im,ls)
  ls = [(306766, '409615398','42712520', '2913697', '4/28/2022 8:32:15 AM'),(306766, '409615398','42712520', '2913697', '4/28/2022 8:32:15 AM')]
  # cursor.executemany(ins,ls)
  cursor.executemany(ins,rec)
  cursor.commit()
  # cursor.executemany(ins,rec2)
  # cursor.commit()
  cursor.close()

except pyodbc.Error as ex:
    ret = 1
    error_msg = ex.args[1]
    print_to_stderr(error_msg) 

except Error as e:
    ret = 1
    print("Error while connecting to database", e)

except BaseException as error:
    ret = 1
    print('An exception occurred: {}'.format(error))

finally:
    end_time = datetime.now()
    tdelta = end_time - start_time 
    print_to_stdout(f"total time: {tdelta}") 
    if 'conn' in globals():
        conn.close()
    # if 'conn2' in globals():
    #     conn2.close()
    # if 'conn3' in globals():
    #     if conn3.is_connected():
    #         conn3.close()
            # print("MySQL connection is closed")

    sys.exit(ret)