confusion_KNN_sum = confusion_KNN_1 + confusion_KNN_2 + confusion_KNN_3 + confusion_KNN_4;
confusion_SVM_sum = confusion_SVM_1 + confusion_SVM_2 + confusion_SVM_3 + confusion_SVM_4;
confusion_LDA_sum = confusion_LDA_1 + confusion_LDA_2 + confusion_LDA_3 + confusion_LDA_4;
plotConfusion(normConfusion(confusion_KNN_sum), 2);
disp(getAcc(confusion_KNN_sum));
plotConfusion(normConfusion(confusion_SVM_sum), 2);
disp(getAcc(confusion_SVM_sum));
plotConfusion(normConfusion(confusion_LDA_sum), 2);
disp(getAcc(confusion_LDA_sum));
mat_KNN = {confusion_KNN_1, confusion_KNN_2, confusion_KNN_3, confusion_KNN_4};
mat_SVM = {confusion_SVM_1, confusion_SVM_2, confusion_SVM_3, confusion_SVM_4};
mat_LDA = {confusion_LDA_1, confusion_LDA_2, confusion_LDA_3, confusion_LDA_4};
[ave, sd] = crossVali(mat_KNN, 4)
[ave, sd] = crossVali(mat_SVM, 4)
[ave, sd] = crossVali(mat_LDA, 4)