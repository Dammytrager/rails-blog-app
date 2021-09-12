user = FactoryGirl.create(:user, :ng, :with_customer_contact, gender: [:male, :female].sample)
user.user_type_test!

Api::WalletsController.find_or_create_investment_account(user: user)
user.fake_customer_upload :selfie
user.fill_primary_financial_account

provider = PaystackBvnReportCreatedKycHelper.send(:identity_provider, user).to_s
bvn_report = user.identity_reports.find_by(identity_type: :BVN, identity_provider: provider) || FactoryGirl.create(:identity_report, identity_provider: provider, identity_type: :BVN, requestor: user)
bvn_report.update(
  payload: {"bvn": user.nat_id_num, "dob": user.dob.strftime('%d-%b-%y'), "mobile":  CustomerContact.infer_isd_and_phone(user.primary_customer_contact.contact_info).last.prepend('0'), "last_name": user.last_name, "first_name": user.first_name, "formatted_dob": user.dob.to_s},
  status: :status_success,
  )

bank_report = user.primary_financial_account.identity_reports.find_by(identity_type: :BankAccount) || FactoryGirl.create(:identity_report, identity_provider: 'PaystackIdentityProvider', identity_type: :BankAccount, identity_number: user.primary_financial_account.account_number, requestor: user.primary_financial_account)
bank_report.update(
  payload: {"account_name": user.legal_name.upcase, "account_number": user.primary_financial_account.account_number},
  status: :status_success,
  )

bvn_link_report = user.primary_financial_account.identity_reports.find_by(identity_type: :BankAccountBvnMatch) || FactoryGirl.create(:identity_report, identity_provider: 'PaystackIdentityProvider', identity_type: :BankAccountBvnMatch, identity_number: user.primary_financial_account.account_number, requestor: user.primary_financial_account)
bvn_link_report.update(
  payload: {"bvn": user.nat_id_num, "account_number": true, "is_blacklisted": false},
  status: :status_success,
  )

KycService.perform(fake_user.wallet.wallet, :wallets, :ng_wallets, :deposit)