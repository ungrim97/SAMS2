INSERT INTO languages (language_code, language_name) VALUES (
    'en',
    'English'
);

INSERT INTO countries (country_code, country_name, language_id) VALUES (
    'GBR',
    'United Kingdom',
    1
);

INSERT INTO account_types (description) VALUES (
    'Institution'
);

INSERT INTO contact_titles (description) VALUES (
    'Mr'
);

INSERT INTO accounts (account_name, account_type_id, contact_title_id, contact_name, street_1, street_2, city, county, postcode, country_id, contact_number, email_address, last_update_user) VALUES (
    'Test Account 1',
    1,
    1,
    'Mike Francis',
    '13 Sterling Close',
    'Worlds End',
    'Burgess Hill',
    'West Sussex',
    'RH15 0PU',
    1,
    '07581208879',
    'mikef@semantico.net',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'account',
    'name',
    'Organisation',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'account',
    'account_id',
    'Account ID',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'account',
    'account_type',
    'Account Type',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'contact',
    'title',
    'Title',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'contact',
    'job_title',
    'Occupation',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'contact',
    'street_1',
    'Address Line 1',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'contact',
    'street_2',
    'Address Line 2',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'contact',
    'city',
    'Town/City',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'contact',
    'county',
    'County',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'contact',
    'postcode',
    'ZIP/Postcode',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'contact',
    'country',
    'Country',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'contact',
    'country',
    'Country',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'contact',
    'phone_number',
    'Phone Number',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'contact',
    'mobile_number',
    'Mobile/Cell Number',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'contact',
    'fax_number',
    'Fax Number',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'contact',
    'email_address',
    'Email Address',
    1
);

INSERT INTO translations (area, name, literal, language_id) VALUES (
    'buttons',
    'submit_changes',
    'Save Changes',
    1
);
