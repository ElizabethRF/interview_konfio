import csv
import cx_Oracle
import datetime
con = cx_Oracle.connect("system", "holamundo1", "localhost/xe")
print("Database version:", con.version)
cur = con.cursor()

rows = [(1, 'Duke', '01/03/18') ]
cur.bindarraysize = 1
cur.executemany('insert into loans.loan_type (id,type, CREATED_DATE) values (:1, :2, (:3) )', rows)



with open('C:\\R\\EXAM\\interview_konfio\\files\\LOAN_TYPE.csv', 'rt') as csvfile:
    reader = csv.reader(csvfile)
    for row in reader:
        print(row)

con.commit()




print (type(rows2))