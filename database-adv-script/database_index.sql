-- User table
CREATE INDEX idx_user_first_name ON User(first_name);
CREATE INDEX idx_user_last_name ON User(last_name);

-- Booking table
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_booking_created_at ON Booking(created_at);

-- Property table
CREATE INDEX idx_property_name ON Property(name);

-- Review table
CREATE INDEX idx_review_property_id ON Review(property_id);
CREATE INDEX idx_review_rating ON Review(rating)
