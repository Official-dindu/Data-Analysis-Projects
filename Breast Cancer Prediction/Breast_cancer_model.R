Model_data<- Breast_cancer_data[,3:31]
cor_matrix <- cor(Model_data)
print(cor_matrix)
Breast_cancer_data$diagnosis<- factor(Breast_cancer_data$diagnosis)
set.seed(123)
Train_index<- sample(1:nrow(Breast_cancer_data), 0.8*nrow(Breast_cancer_data))
Train_data<- Breast_cancer_data[Train_index,]
Test_data<- Breast_cancer_data[-Train_index,]
Model<- glm(diagnosis ~ texture_mean + area_mean +
              smoothness_mean + 
              concave.points_mean + symmetry_mean + 
              fractal_dimension_mean +
              symmetry_mean,
            data = Train_data , family = binomial)
print(Model)
Predictions<- predict(Model, newdata = Test_data, type = "response")
Class<- ifelse(Predictions > 0.5, "M", "B")
table(predicted = Class, Actual =Test_data$diagnosis) 
Confusion_matrix<- table(predicted = Class, Actual =Test_data$diagnosis)
True_postive<- Confusion_matrix["M","M"]
True_negative<- Confusion_matrix["B","B"]
False_positive<- Confusion_matrix["M","B"]
False_negative<- Confusion_matrix["B","M"]
Model_accuracy<- (True_postive + True_negative)/(True_postive + True_negative +
                                  False_positive + False_negative)
print(Model_accuracy)
Precision<- (True_postive)/ (True_postive + False_positive)
print(Precision)                                                  
Recall<- (True_postive)/(True_postive + False_negative)
print(Recall)
install.packages("pROC")
library(pROC)
roc_curve<- roc(Test_data$diagnosis, Predictions)
plot(roc_curve)
auc(roc_curve)
