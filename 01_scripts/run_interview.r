options(warn=0)
rm(list = ls())
source('C:/R/EXAM/interview_konfio/scripts/Renviron.r', encoding = 'UTF-8')
Sys.setenv(JAVA_HOME=JAVAPATH_)
library(rJava)
library(RJDBC)


   


dfCustomer <- read.csv("/R/EXAM/interview_konfio/files/CUSTOMER.csv")
dfLoan     <- read.csv("/R/EXAM/interview_konfio/files/LOAN.csv")
dfPayment  <- read.csv("/R/EXAM/interview_konfio/files/PAYMENT.csv")
dfLoanType <- read.csv("/R/EXAM/interview_konfio/files/LOAN_TYPE.csv")


driver<- JDBC(driverClass ="oracle.jdbc.OracleDriver",classPath=CLASSPATH_)

jdbcConnection <- dbConnect(driver, URL_, USER_, PASS_)



dbWriteTable(jdbcConnection,"LOANS.CUSTOMER", dfCustomer)
dbWriteTable(jdbcConnection,"LOANS.LOAN", dfLoan)
dbWriteTable(jdbcConnection,"LOANS.LOAN2", dfLoan)
dbWriteTable(jdbcConnection,"LOANS.LOAN_TYPE", dfLoanType)
dbWriteTable(jdbcConnection,"LOANS.PAYMENT", dfPayment)
dbWriteTable(jdbcConnection,"LOANS.PAYMENT2", dfPayment)





print("listo")