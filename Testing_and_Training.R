#10) Splitting the 16 + dummy 6 col data set to training data set and test data set.
sample_size <- floor(0.8 * nrow(listings.spec.cols))
set.seed(123)
train_ind <- sample(seq_len(nrow(listings.spec.cols)), size = sample_size)
list_traning_data <- listings.spec.cols[train_ind,] 
list_test_data <- listings.spec.cols[-train_ind, ]

