INSERT INTO countries (country_code, country_name) VALUES (
    'GBR',
    'United Kingdom'
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
