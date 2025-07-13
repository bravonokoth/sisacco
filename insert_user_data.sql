-- Insert test data for born@winner.com (UUID: 2c31c722-8843-435a-9e90-2074ac51e639)

-- First, insert loan products (if not already inserted)
INSERT INTO loan_products (name, description, min_amount, max_amount, interest_rate, max_term, requirements, eligibility_criteria) VALUES
('Personal Loan', 'Flexible personal loan for various needs', 1000.00, 50000.00, 12.50, 60, ARRAY['Valid ID', 'Proof of Income', 'Bank Statement'], 'Minimum monthly income of $2000'),
('Home Loan', 'Mortgage loan for home purchase', 50000.00, 2000000.00, 8.75, 360, ARRAY['Valid ID', 'Proof of Income', 'Property Documents', 'Down Payment'], 'Minimum credit score of 650'),
('Car Loan', 'Auto financing for vehicle purchase', 5000.00, 100000.00, 10.25, 84, ARRAY['Valid ID', 'Proof of Income', 'Vehicle Documents'], 'Minimum monthly income of $1500'),
('Business Loan', 'Working capital for business expansion', 10000.00, 500000.00, 15.00, 120, ARRAY['Business Registration', 'Financial Statements', 'Business Plan'], 'Minimum 2 years in business')
ON CONFLICT (name) DO NOTHING;

-- Insert user profile for born@winner.com
INSERT INTO user_profiles (user_id, email, first_name, last_name, phone_number, kyc_status) VALUES
('2c31c722-8843-435a-9e90-2074ac51e639', 'born@winner.com', 'Born', 'Winner', '+1234567890', 'verified');

-- Insert accounts for born@winner.com
INSERT INTO accounts (user_id, name, account_number, balance, type, interest_rate, open_date) VALUES
('2c31c722-8843-435a-9e90-2074ac51e639', 'Main Savings', '1234567890', 5000.00, 'savings', 2.50, '2024-01-15'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Checking Account', '1234567891', 2500.00, 'checking', 0.00, '2024-01-15'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Fixed Deposit', '1234567892', 10000.00, 'fixedDeposit', 5.00, '2024-01-15'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Investment Account', '1234567893', 15000.00, 'shares', 8.00, '2024-02-01');

-- Insert transactions for born@winner.com
INSERT INTO transactions (user_id, description, amount, type, category, reference) VALUES
('2c31c722-8843-435a-9e90-2074ac51e639', 'Salary Deposit', 3000.00, 'credit', 'Salary', 'SAL-001'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Grocery Shopping', -150.00, 'debit', 'Food', 'GROC-001'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Gas Station', -45.00, 'debit', 'Transportation', 'GAS-001'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Online Purchase', -89.99, 'debit', 'Shopping', 'ONLINE-001'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Interest Earned', 12.50, 'credit', 'Interest', 'INT-001'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Restaurant Payment', -75.00, 'debit', 'Food', 'REST-001'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Utility Bill Payment', -120.00, 'debit', 'Utilities', 'UTIL-001'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Investment Dividend', 500.00, 'credit', 'Investment', 'DIV-001'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Phone Bill', -85.00, 'debit', 'Utilities', 'PHONE-001'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Freelance Payment', 1500.00, 'credit', 'Freelance', 'FREELANCE-001');

-- Insert a loan for born@winner.com
INSERT INTO loans (user_id, product_id, product_name, principal_amount, outstanding_balance, monthly_payment, interest_rate, status, term_months) VALUES
('2c31c722-8843-435a-9e90-2074ac51e639', (SELECT id FROM loan_products WHERE name = 'Personal Loan'), 'Personal Loan', 10000.00, 8500.00, 250.00, 12.50, 'active', 48);

-- Insert notifications for born@winner.com
INSERT INTO notifications (user_id, title, message, type) VALUES
('2c31c722-8843-435a-9e90-2074ac51e639', 'Welcome to Sisacco', 'Thank you for joining our banking platform!', 'info'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Loan Payment Due', 'Your loan payment of $250 is due in 5 days', 'warning'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Account Verified', 'Your account has been successfully verified', 'success'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'New Investment Opportunity', 'Check out our latest investment products', 'info'),
('2c31c722-8843-435a-9e90-2074ac51e639', 'Security Alert', 'New login detected from your device', 'warning'); 