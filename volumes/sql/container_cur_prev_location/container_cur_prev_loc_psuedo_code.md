# Psuedo Code

## references

<https://tabletomarkdown.com/convert-spreadsheet-to-markdown/>

```psuedo_code

order container_change2 by pcn,serial_no,change_key desc

# intialize variables
input_record = 1
location_change_cnt = 0
cur_pcn = pcn
cur_serial_no = serial_no
cur__location = location

# insert 1st record
insert pcn,serial_no,location,employee,change_date into result_set

input_record = input_record + 1
cur_employee = employee
location_change_date = change_date

while record <= max_record
    # pcn change
    if (pcn<>cur_pcn and serial_no <> cur_serial_no and location <> cur_location) then
        location_change_cnt = 0
        insert location_change_cnt,pcn,serial_no,location,employee,location_change_date into result_set
    # pcn change
    else_if (pcn<>cur_pcn and serial_no <> cur_serial_no and location = cur_location) then
        location_change_cnt = 0
        insert location_change_cnt,pcn,serial_no,location,employee,location_change_date into result_set
    # pcn change
    else_if (pcn<>cur_pcn and serial_no = cur_serial_no and location <> cur_location) then
        location_change_cnt = 0
        insert location_change_cnt,pcn,serial_no,location,employee,location_change_date into result_set
    # pcn change
    else_if (pcn<>cur_pcn and serial_no = cur_serial_no and location = cur_location) then
        location_change_cnt = 0
        insert location_change_cnt,pcn,serial_no,location,employee,location_change_date into result_set
    # serial_no change
    else_if (pcn=cur_pcn and serial_no <> cur_serial_no and location <> cur_location) then
        location_change_cnt = 0
        insert location_change_cnt,pcn,serial_no,location,employee,location_change_date into result_set
    # serial_no change
    else_if (pcn=cur_pcn and serial_no <> cur_serial_no and location = cur_location) then
        location_change_cnt = 0
        insert location_change_cnt,pcn,serial_no,location,employee,location_change_date into result_set
    # location change
    else_if (pcn=cur_pcn and serial_no = cur_serial_no and location <> cur_location) then
        location_change_cnt=location_change_cnt+1
        insert location_change,pcn,serial_no,location,employee,location_change_date into result_set
    # no change
    else_if (pcn=cur_pcn and serial_no = cur_serial_no and location = cur_location) then
        # don't insert record
    input_record = input_record + 1
    cur_employee = employee
    location_change_date = change_date

# Add part number and revision info to result_set

# Pivot x serial_number location changes


```
