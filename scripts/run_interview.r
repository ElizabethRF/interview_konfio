install.packages('RODBC')
library(RODBC)



if(!file.exists("/R/EXAM"))
   {
     dir.create("/R/EXAM")
   }
##Create directory if does't exists
   
   

setwd("/R/EXAM")

dfCustomer <- read.csv("C:/R/EXAM/files/CUSTOMER.csv")


dfLoan <- read.csv("C:/R/EXAM/files/LOAN.csv")
dfLoanType <- read.csv("C:/R/EXAM/files/LOAN_TYPE.csv")
dfPayment <- read.csv("C:/R/EXAM/files/PAYMENT.csv")
dfPayment <- read.csv("C:/R/EXAM/files/PAYMENT.csv")