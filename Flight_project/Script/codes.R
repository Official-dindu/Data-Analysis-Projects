Flight_data$Delayed <- as.factor(Flight_data$Delayed)
Flight_data$Weather_Conditions <- as.factor(Flight_data$Weather_Conditions)
Flight_data$Day_of_Week <- as.factor(Flight_data$Day_of_Week)
Flight_data$Airline <- as.factor(Flight_data$Airline)
set.seed(123)
Train_index<- sample(1:nrow(Flight_data), 0.8*nrow(Flight_data))
Train_data<- Flight_data[Train_index,]
Test_data<- Flight_data[-Train_index,]
Model <-glm(Delayed ~ Flight_Duration + Day_of_Week + Weather_Conditions, data = Flight_data, family = binomial)
print(Model)
Predictions<- predict(Model, newdata = Test_data, type = "response")
Class<- ifelse(Predictions > 0.5, 1, 0)
Comparism <- data.frame(Actual =Test_data$Delayed, predicted = Class )
print(Comparism)
table(predicted = Class, Actual =Test_data$Delayed) 
Confusion_matrix<- table(predicted = Class, Actual =Test_data$Delayed)
True_positive<- Confusion_matrix[2,2]
True_negative<- Confusion_matrix[1,1]
False_positive<- Confusion_matrix[2,1]
False_negative<- Confusion_matrix[1,2]
Model_accuracy<- (True_positive + True_negative)/sum(Confusion_matrix)
print(Model_accuracy)
Precision<- (True_positive)/ (True_positive + False_positive)
print(Precision)  
dir.create("Model")
saveRDS(Model,"Model/flight_model.rds")
load_model<- readRDS("Model/flight_model.rds")
print(load_model)
