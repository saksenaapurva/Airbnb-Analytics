

#3) Exploratory Data Analysis beigns here
#1) Find mean and sd across beds
ddply(listings2,~beds, summarize, mean=mean(price))

mod1 <- lm(listings2$price ~ listings2$beds, data = listings2)
summary(mod1)
with(listings2, plot(listings2$price ~ listings2$beds))
abline(mod1)

#2) histogram for price 
hist(listings2$price, breaks = 50, xlab = "Listing's Price", main = "Histogram of Listing prices", col="Orange")

#3) scatter plot of price vs no. of bedrooms
plot(listings2$bedrooms, listings2$price,  ylab = "Listing price", xlab = "Number of Bedrooms")

#4) Number of reviews vs price
plot(listings2$number_of_reviews, listings2$price,  ylab = "Listing price", xlab = "Number of Reviews", col = "Orange")


#5) Creating columns and scatter plot with 8 variables
pairs(listings.spec.cols[ , c("price", "beds", "bedrooms", "bathrooms", "accommodates", "host_listings_count", "host_acceptance_rate", "number_of_reviews")], pch = 19)

#6 ) 8 col selected
listings.low.cols <- listings.spec.cols[ , c("price", "beds", "bedrooms", "bathrooms", "accommodates", "host_listings_count", "number_of_reviews")]


#7) Correlation between all the 8 variables
ggplot(listings.low.cols, aes(listings.low.cols, listings.low.cols)) + scale_fill_gradient(low="white", high = "red")
col <- colorRampPalette(c("Red", "Blue"))(20)
m <- cor(listings.low.cols_narm)
corrplot(m, col = col, method ="number")

#8) creating a new df with selected cols: 16 cols
listings.spec.cols <- listings2 %>% 
  select(host_response_rate, host_acceptance_rate, host_is_superhost, host_listings_count, zipcode, property_type, room_type, accommodates, bathrooms, bedrooms, beds, price, number_of_reviews, review_scores_rating, cancellation_policy, reviews_per_month)

#9) Removing the NA rows from our subset of 16 cols data frame
listings.spec.cols[listings.spec.cols == "N/A"] <- NA
listings.spec.cols <- listings.spec.cols %>% drop_na()

#10) dummy encoding for categorical variables
cancellation_policy_dummy <- model.matrix( ~ listings.spec.cols$cancellation_policy - 1, data=listings.spec.cols )
listings.spec.cols <- cbind(listings.spec.cols, cancellation_policy_dummy)

room_type_dummy <- model.matrix( ~ listings.spec.cols$room_type - 1, data=listings.spec.cols )
listings.spec.cols <- cbind(listings.spec.cols, room_type_dummy)

property_type_dummy <- model.matrix( ~ listings.spec.cols$property_type - 1, data=listings.spec.cols )
listings.spec.cols <- cbind(listings.spec.cols, property_type_dummy)

zipcode_type_dummy <- model.matrix( ~ listings.spec.cols$zipcode - 1, data=listings.spec.cols )
listings.spec.cols <- cbind(listings.spec.cols, zipcode_type_dummy)

#listings.spec.cols$room_type <- NULL
#listings.spec.cols$zipcode <- NULL
#listings.spec.cols$cancellation_policy <- NULL
#listings.spec.cols$property_type <- NULL
#listings.spec.cols$`listings.spec.cols$zipcode <- NULL`
#listings.spec.cols$`listings.spec.cols$property_type` <- NULL

