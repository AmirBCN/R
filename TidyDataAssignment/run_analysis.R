setwd("/Users/AmirSona/Desktop/R/TidyDataAssignment/test")
testX <- read.table("X_test.txt")
testY <- read.table("y_test.txt")
testsubject <- read.table("subject_test.txt")
setwd("/Users/AmirSona/Desktop/R/TidyDataAssignment/test/Inertial Signals")
#### Acc
testBAX <- read.table("body_acc_x_test.txt")
testBAY <- read.table("body_acc_y_test.txt")
testBAZ <- read.table("body_acc_z_test.txt")
#### Gyro
testBGX <- read.table("body_gyro_x_test.txt")
testBGY <- read.table("body_gyro_y_test.txt")
testBGZ <- read.table("body_gyro_z_test.txt")
#### Total acc
testTAX <- read.table("total_acc_x_test.txt")
testTAY <- read.table("total_acc_y_test.txt")
testTAZ <- read.table("total_acc_z_test.txt")

#setwd("/Users/AmirSona/Desktop/R/TidyDataAssignment/train")

