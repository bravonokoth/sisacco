-- Insert Loan Products
INSERT INTO loan_products (name, description, min_amount, max_amount, interest_rate, max_term, requirements, eligibility_criteria) VALUES
('Personal Loan', 'Flexible personal loan for various needs', 1000.00, 50000.00, 12.50, 60, ARRAY['Valid ID', 'Proof of Income', 'Bank Statement'], 'Minimum monthly income of $2000'),
('Home Loan', 'Mortgage loan for home purchase', 50000.00, 2000000.00, 8.75, 360, ARRAY['Valid ID', 'Proof of Income', 'Property Documents', 'Down Payment'], 'Minimum credit score of 650'),
('Car Loan', 'Auto financing for vehicle purchase', 5000.00, 100000.00, 10.25, 84, ARRAY['Valid ID', 'Proof of Income', 'Vehicle Documents'], 'Minimum monthly income of $1500'),
('Business Loan', 'Working capital for business expansion', 10000.00, 500000.00, 15.00, 120, ARRAY['Business Registration', 'Financial Statements', 'Business Plan'], 'Minimum 2 years in business');

-- Insert test user profiles (you'll need to create these users in Auth first)
-- Note: Replace the user_id values with actual UUIDs from your auth.users table

-- First, let's create some test users in the auth system
-- You'll need to do this manually in the Supabase Auth dashboard or use the API

-- After creating users, insert their profiles (replace user_id with actual UUIDs)
-- Example: INSERT INTO user_profiles (user_id, email, first_name, last_name, phone_number, kyc_status) VALUES
-- ('actual-uuid-here', 'john.doe@example.com', 'John', 'Doe', '+1234567890', 'verified');

-- Insert sample accounts (replace user_id with actual UUIDs)
-- Example: INSERT INTO accounts (user_id, name, account_number, balance, type, interest_rate, open_date) VALUES
-- ('actual-uuid-here', 'Main Savings', '1234567890', 5000.00, 'savings', 2.50, '2024-01-15');

-- Insert sample transactions (replace user_id and account_id with actual UUIDs)
-- Example: INSERT INTO transactions (user_id, description, amount, type, category, reference) VALUES
-- ('actual-uuid-here', 'Salary Deposit', 3000.00, 'credit', 'Salary', 'SAL-001');

-- Insert sample loans (replace user_id with actual UUIDs)
-- Example: INSERT INTO loans (user_id, product_id, product_name, principal_amount, outstanding_balance, monthly_payment, interest_rate, status, term_months) VALUES
-- ('actual-uuid-here', (SELECT id FROM loan_products WHERE name = 'Personal Loan'), 'Personal Loan', 10000.00, 8500.00, 250.00, 12.50, 'active', 48);

-- Insert sample notifications (replace user_id with actual UUIDs)
-- Example: INSERT INTO notifications (user_id, title, message, type) VALUES
-- ('actual-uuid-here', 'Welcome to Sisacco', 'Thank you for joining our banking platform!', 'info'); 