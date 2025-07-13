-- This script creates test users and their data
-- Run this after creating the tables with database_setup.sql

-- First, create test users in the auth system (you'll need to do this manually in Supabase Auth dashboard)
-- Or use the Supabase Auth API to create users programmatically

-- After creating users, get their UUIDs and replace them in the queries below

-- Example test user data (replace the UUIDs with actual user IDs from auth.users)
-- You can find user UUIDs in Supabase Dashboard → Authentication → Users

-- Test User 1: John Doe
-- UUID: (replace with actual UUID from auth.users)
INSERT INTO user_profiles (user_id, email, first_name, last_name, phone_number, kyc_status) VALUES
('REPLACE_WITH_ACTUAL_UUID', 'john.doe@example.com', 'John', 'Doe', '+1234567890', 'verified');

-- Test User 2: Jane Smith  
-- UUID: (replace with actual UUID from auth.users)
INSERT INTO user_profiles (user_id, email, first_name, last_name, phone_number, kyc_status) VALUES
('REPLACE_WITH_ACTUAL_UUID', 'jane.smith@example.com', 'Jane', 'Smith', '+1234567891', 'verified');

-- Test User 3: Admin User
-- UUID: (replace with actual UUID from auth.users)
INSERT INTO user_profiles (user_id, email, first_name, last_name, phone_number, kyc_status) VALUES
('REPLACE_WITH_ACTUAL_UUID', 'admin@sisacco.com', 'Admin', 'User', '+1234567892', 'verified');

-- Insert accounts for John Doe (replace user_id with actual UUID)
INSERT INTO accounts (user_id, name, account_number, balance, type, interest_rate, open_date) VALUES
('REPLACE_WITH_ACTUAL_UUID', 'Main Savings', '1234567890', 5000.00, 'savings', 2.50, '2024-01-15'),
('REPLACE_WITH_ACTUAL_UUID', 'Checking Account', '1234567891', 2500.00, 'checking', 0.00, '2024-01-15'),
('REPLACE_WITH_ACTUAL_UUID', 'Fixed Deposit', '1234567892', 10000.00, 'fixedDeposit', 5.00, '2024-01-15');

-- Insert accounts for Jane Smith (replace user_id with actual UUID)
INSERT INTO accounts (user_id, name, account_number, balance, type, interest_rate, open_date) VALUES
('REPLACE_WITH_ACTUAL_UUID', 'Savings Account', '1234567893', 3000.00, 'savings', 2.50, '2024-02-01'),
('REPLACE_WITH_ACTUAL_UUID', 'Business Account', '1234567894', 15000.00, 'checking', 0.00, '2024-02-01');

-- Insert transactions for John Doe (replace user_id with actual UUID)
INSERT INTO transactions (user_id, description, amount, type, category, reference) VALUES
('REPLACE_WITH_ACTUAL_UUID', 'Salary Deposit', 3000.00, 'credit', 'Salary', 'SAL-001'),
('REPLACE_WITH_ACTUAL_UUID', 'Grocery Shopping', -150.00, 'debit', 'Food', 'GROC-001'),
('REPLACE_WITH_ACTUAL_UUID', 'Gas Station', -45.00, 'debit', 'Transportation', 'GAS-001'),
('REPLACE_WITH_ACTUAL_UUID', 'Online Purchase', -89.99, 'debit', 'Shopping', 'ONLINE-001'),
('REPLACE_WITH_ACTUAL_UUID', 'Interest Earned', 12.50, 'credit', 'Interest', 'INT-001');

-- Insert transactions for Jane Smith (replace user_id with actual UUID)
INSERT INTO transactions (user_id, description, amount, type, category, reference) VALUES
('REPLACE_WITH_ACTUAL_UUID', 'Business Income', 5000.00, 'credit', 'Business', 'BIZ-001'),
('REPLACE_WITH_ACTUAL_UUID', 'Office Supplies', -200.00, 'debit', 'Business', 'OFFICE-001'),
('REPLACE_WITH_ACTUAL_UUID', 'Client Payment', 2500.00, 'credit', 'Business', 'CLIENT-001');

-- Insert loans for John Doe (replace user_id with actual UUID)
INSERT INTO loans (user_id, product_id, product_name, principal_amount, outstanding_balance, monthly_payment, interest_rate, status, term_months) VALUES
('REPLACE_WITH_ACTUAL_UUID', (SELECT id FROM loan_products WHERE name = 'Personal Loan'), 'Personal Loan', 10000.00, 8500.00, 250.00, 12.50, 'active', 48);

-- Insert notifications for John Doe (replace user_id with actual UUID)
INSERT INTO notifications (user_id, title, message, type) VALUES
('REPLACE_WITH_ACTUAL_UUID', 'Welcome to Sisacco', 'Thank you for joining our banking platform!', 'info'),
('REPLACE_WITH_ACTUAL_UUID', 'Loan Payment Due', 'Your loan payment of $250 is due in 5 days', 'warning'),
('REPLACE_WITH_ACTUAL_UUID', 'Account Verified', 'Your account has been successfully verified', 'success');

-- Insert notifications for Jane Smith (replace user_id with actual UUID)
INSERT INTO notifications (user_id, title, message, type) VALUES
('REPLACE_WITH_ACTUAL_UUID', 'Welcome to Sisacco', 'Thank you for joining our banking platform!', 'info'),
('REPLACE_WITH_ACTUAL_UUID', 'Business Account Activated', 'Your business account is now active', 'success'); 