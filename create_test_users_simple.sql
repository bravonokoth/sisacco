-- First, create these users manually in Supabase Dashboard → Authentication → Users
-- Then run this script to insert their profile data

-- Insert loan products first (these don't need user IDs)
INSERT INTO loan_products (name, description, min_amount, max_amount, interest_rate, max_term, requirements, eligibility_criteria) VALUES
('Personal Loan', 'Flexible personal loan for various needs', 1000.00, 50000.00, 12.50, 60, ARRAY['Valid ID', 'Proof of Income', 'Bank Statement'], 'Minimum monthly income of $2000'),
('Home Loan', 'Mortgage loan for home purchase', 50000.00, 2000000.00, 8.75, 360, ARRAY['Valid ID', 'Proof of Income', 'Property Documents', 'Down Payment'], 'Minimum credit score of 650'),
('Car Loan', 'Auto financing for vehicle purchase', 5000.00, 100000.00, 10.25, 84, ARRAY['Valid ID', 'Proof of Income', 'Vehicle Documents'], 'Minimum monthly income of $1500'),
('Business Loan', 'Working capital for business expansion', 10000.00, 500000.00, 15.00, 120, ARRAY['Business Registration', 'Financial Statements', 'Business Plan'], 'Minimum 2 years in business');

-- After creating users manually, get their UUIDs and run these queries:
-- Replace 'USER_UUID_HERE' with actual UUIDs from auth.users table

-- Example for John Doe (replace with actual UUID):
-- INSERT INTO user_profiles (user_id, email, first_name, last_name, phone_number, kyc_status) VALUES
-- ('USER_UUID_HERE', 'john.doe@example.com', 'John', 'Doe', '+1234567890', 'verified');

-- Example for Jane Smith (replace with actual UUID):
-- INSERT INTO user_profiles (user_id, email, first_name, last_name, phone_number, kyc_status) VALUES
-- ('USER_UUID_HERE', 'jane.smith@example.com', 'Jane', 'Smith', '+1234567891', 'verified');

-- Example for Admin (replace with actual UUID):
-- INSERT INTO user_profiles (user_id, email, first_name, last_name, phone_number, kyc_status, metadata) VALUES
-- ('USER_UUID_HERE', 'admin@sisacco.com', 'Admin', 'User', '+1234567892', 'verified', '{"role": "admin"}'); 